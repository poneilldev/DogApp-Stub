//
//  ContentView.swift
//  Shared
//
//  Created by Paul O'Neill on 2022-08-16.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel: ViewModel
    
    var body: some View {
        NavigationView {
            VStack {
                switch self.viewModel.state {
                    case .loading:
                        ProgressView()
                            .task {
                                await self.viewModel.loadAllBreeds()
                            }
                    case .loaded(let breeds):
                        DogListView(breeds: breeds)
                    case .empty(let message):
                        Text(message)
                    case .error(let error):
                        Text(error.localizedDescription)
                }
            }
            .listStyle(.insetGrouped)
            .navigationTitle("Dog Breeds")
        }
    }
}

struct DogListView: View {
    let breeds: [Breed]
    
    var body: some View {
        List {
          ForEach(breeds, id: \.name) { breed in
                NavigationLink(destination: DogDetails(breed: breed)) {
                    DogCellView(breed: breed)
                }
            }
        }
    }
}

struct DogCellView: View {
    let breed: Breed
    
    var body: some View {
        Text(breed.name)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: ContentView.ViewModel(DogService()))
    }
}
