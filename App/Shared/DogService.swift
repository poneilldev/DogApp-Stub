//
//  DogService.swift
//  DogApp
//
//  Created by Paul O'Neill on 2022-08-16.
//

import Foundation

protocol DogServiceProtocol {
    func getAllBreeds() async throws -> [Breed]
    func getSubBreed(for breed: Breed) async throws -> [Breed]
}

/// The service for getting all the different types of breeds of dogs.
struct DogService: DogServiceProtocol {
    private static let endpoint = "https://dog.ceo/api/"
    
    /// This method makes a network call to retreive all breeds.
    /// - Returns: An array of all available breeds.
    func getAllBreeds() async throws -> [Breed] {
        let url = URL(string: Self.endpoint.appending("breeds/list/all"))!
        // TODO: Implement
        return []
    }
    
    /// This method makes a network call to retreive all breeds.
    /// - Parameter breed: The parent breed.
    /// - Returns: An array of sub breeds for the parent breed.
    func getSubBreed(for breed: Breed) async throws -> [Breed] {
        let url = URL(string: Self.endpoint.appending("breed/\(breed.name)/list"))!
        return []
    }
}
