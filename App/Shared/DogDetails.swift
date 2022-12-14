//
//  DogDetails.swift
//  DogApp
//
//  Created by Paul O'Neill on 2022-08-16.
//

import Foundation
import SwiftUI

struct DogDetails: View {
    let breed: Breed
    
    var body: some View {
        VStack {
            if breed.subBreeds.isEmpty {
                Text("No Sub Breeds")
            } else {
                List {
                    ForEach(breed.subBreeds, id: \.self) { subBreed in
                        Text(subBreed)
                    }
                }
            }
        }
        .navigationTitle(breed.name)

    }
}
