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
                if self.viewModel.isLoading {
                    ProgressView()
                } else {
                    List {
                      ForEach(self.viewModel.searchedBreeds, id: \.name) { breed in
                            NavigationLink(destination: DogDetails(breed: breed)) {
                                DogCellView(breed: breed)
                            }
                        }
                    }
                    .searchable(text: self.$viewModel.searchText)
                    .onChange(of: self.viewModel.searchText) { newValue in
                        self.viewModel.filterResults()
                    }
                }
            }
            .listStyle(.insetGrouped)
            .navigationTitle("Dogs")
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
