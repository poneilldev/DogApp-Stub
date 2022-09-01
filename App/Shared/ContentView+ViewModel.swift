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
        
        @Published private(set) var breeds: [Breed] = []
        @Published private(set) var isLoading: Bool = false
        @Published private(set) var error: Error?
        
        init(_ service: DogServiceProtocol = DogService()) {
            self.service = service
            Task {
                await self.loadAllBreeds()
            }
        }
        
        func loadAllBreeds() async {
            self.isLoading = true
            do {
                let resource = try await service.getAllBreeds()
                self.breeds = resource.breeds
                self.sortBreeds()
            } catch let err {
                self.error = err
            }
            
            self.isLoading = false
        }
        
        func sortBreeds() {
            // TODO: Write Sorting methods
        }
        
        func filterResults() {
            // TODO: Write filter logic
        }
    }
}
