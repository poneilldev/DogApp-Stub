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
        @Published var searchText = ""
        @Published var searchedBreeds: [Breed] = []
        
        @Published private(set) var breeds: [Breed] = []
        @Published private(set) var isLoading: Bool = false
        @Published private(set) var error: Error?
        
        init(_ service: DogServiceProtocol) {
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
                self.searchedBreeds = resource.breeds
                self.sortBreeds()
            } catch let err {
                self.error = err
            }
            
            self.isLoading = false
        }
        
        func sortBreeds() {
            //sort from A to Z
            self.breeds = self.breeds.sorted { $0.name < $1.name }
            self.searchedBreeds = self.searchedBreeds.sorted { $0.name < $1.name }
        }
        
        func filterResults() {
            guard !searchText.isEmpty else {
                self.searchedBreeds = self.breeds
                return
            }
            
            let tempBreeds = self.searchedBreeds.filter( { $0.name.contains( searchText.lowercased() )} )
            self.searchedBreeds = tempBreeds
        }
    }
}
