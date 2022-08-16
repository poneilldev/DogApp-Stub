//
//  DogService.swift
//  DogApp
//
//  Created by Paul O'Neill on 2022-08-16.
//

import Foundation

protocol DogServiceProtocol {
    func getAllBreeds() async throws -> BreedResource
    func getRandomImage(for breed: Breed) async throws -> BreedImage
    func getSubBreed(for breed: Breed) async throws -> BreedResource
}

struct DogService: DogServiceProtocol {
    private static let domain = "https://dog.ceo/api/"
    
    func getAllBreeds() async throws -> BreedResource {
        let url = URL(string: Self.domain.appending("breeds/list/all"))!
        let (data, _) = try await URLSession.shared.data(from: url)
        let decoder = JSONDecoder()
        return try decoder.decode(BreedResource.self, from: data)
    }
    
    func getRandomImage(for breed: Breed) async throws -> BreedImage {
        let url = URL(string: Self.domain.appending("breed/\(breed.name)/images/random"))!
        let (data, _) = try await URLSession.shared.data(from: url)
        let decoder = JSONDecoder()
        return try decoder.decode(BreedImage.self, from: data)
    }
    
    func getSubBreed(for breed: Breed) async throws -> BreedResource {
        let url = URL(string: Self.domain.appending("breed/\(breed.name)/list"))!
        let (data, _) = try await URLSession.shared.data(from: url)
        let decoder = JSONDecoder()
        return try decoder.decode(BreedResource.self, from: data)
    }
}
