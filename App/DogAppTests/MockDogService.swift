//
//  MockDogService.swift
//  DogAppTests
//
//  Created by Paul O'Neill on 2022-09-06.
//

import Foundation
@testable import DogApp

struct MockDogService: DogServiceProtocol {
    private var breeds: [Breed] = []
    
    init(_ breeds: [Breed]) {
        self.breeds = breeds
    }
    
    func getAllBreeds() async throws -> [Breed] {
        return self.breeds
    }
}
