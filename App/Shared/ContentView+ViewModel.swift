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
        
        /// All the breeds available.
        @Published private(set) var breeds: [Breed] = []
        /// The state of the view.
        @Published private(set) var state: State = .loading
        
        init(_ service: DogService = .init()) {
            self.service = service
        }
        
        /// Make a call to Dog Service to get all of the breeds.
        func loadAllBreeds() async {
            // TODO: Implement method
        }
        
        /// Sort the breeds by name.
        func sortBreeds() {
            // TODO: Implement method
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
