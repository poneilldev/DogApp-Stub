//
//  ContentView+ViewModel.swift
//  DogApp
//
//  Created by Paul O'Neill on 2022-08-16.
//

import Foundation

extension ContentView {
    @MainActor
    class ViewModel: ObservableObject {
        let service: DogService
        
        @Published private(set) var breeds: [Breed] = []
        @Published private(set) var state: State = .loading
        
        init(_ service: DogService = .init()) {
            self.service = service
        }
        
        func loadAllBreeds() async {
            self.state = .loading
            do {
                let resource = try await service.getAllBreeds()
                self.breeds = resource.breeds
                self.state = .loaded(results: self.breeds)
            } catch let err {
                self.state = .error(err)
            }
        }
        
        func sortBreeds() {
            // TODO: Write Sorting methods
        }
        
        func filterResults() {
            // TODO: Write filter logic
        }
    }
}

extension ContentView {
    enum State {
        case loaded(results: [Breed])
        case loading
        case error(Error)
        case empty(String)
    }
}
