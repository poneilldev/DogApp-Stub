//
//  Breed.swift
//  DogApp
//
//  Created by Paul O'Neill on 2022-08-16.
//

import Foundation

struct Breed {
    let name: String
    let subBreeds: [String]
}

extension Breed: Equatable {}

struct BreedResource: Codable {
    let message: [String: [String]]
    let status: String
    
    var breeds: [Breed] {
        return message.compactMap({ Breed(name: $0.key, subBreeds: $0.value) })
    }
        
    enum CodingKeys: String, CodingKey {
        case message
        case status
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        message = try container.decode([String: [String]].self, forKey: .message)
        status = try container.decode(String.self, forKey: .status)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(message, forKey: .message)
        try container.encode(status, forKey: .status)
    }
    
    init(message: [String: [String]], status: String) {
        self.message = message
        self.status = status
    }
}
