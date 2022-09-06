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
        let service: DogServiceProtocol
        
        /// All the breeds available.
        @Published private(set) var breeds: [Breed] = []
        /// The state of the view.
        @Published private(set) var state: State = .loading
        
        init(_ service: DogServiceProtocol = DogService()) {
            self.service = service
        }
        
        /// Make a call to Dog Service to get all of the breeds.
        func loadAllBreeds() async {
            do {
                let breeds = try await service.getAllBreeds()
                if breeds.isEmpty {
                    state = .empty("No breeds available")
                }
                else {
                    self.sortBreeds()
                    state = .loaded(results: breeds)
                    self.breeds = breeds
                }
            }
            catch {
                state = .error(error)
            }
        }

        
        /// Sort the breeds by name.
        func sortBreeds() {
            self.breeds.sort { $0.name < $1.name }
        }
        
        /// Filter the breeds by the text in the search bar.
        func filterResults() {
            // TODO: Implement method
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


