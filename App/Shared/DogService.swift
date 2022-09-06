//
//  DogService.swift
//  DogApp
//
//  Created by Paul O'Neill on 2022-08-16.
//

import Foundation

protocol DogServiceProtocol {
    func getAllBreeds() async throws -> [Breed]
}

/// The service for getting all the different types of breeds of dogs.
struct DogService: DogServiceProtocol {
    private static let endpoint = "https://dog.ceo/api/"
    
    /// This method makes a network call to retreive all breeds.
    /// - Returns: An array of all available breeds.
    func getAllBreeds() async throws -> [Breed] {
        let url = URL(string: Self.endpoint.appending("breeds/list/all"))!
        let (data, _) = try await URLSession.shared.data(from: url)
        let decoder = JSONDecoder()
        let resource = try decoder.decode(BreedResource.self, from: data)
        return resource.breeds
    }
}
