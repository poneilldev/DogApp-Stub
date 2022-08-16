//
//  ContentView+ViewModelTests.swift
//  DogAppTests
//
//  Created by Paul O'Neill on 2022-08-16.
//

@testable import DogApp
import XCTest

class ContentView_ViewModelTests: XCTestCase {
    var sut: ContentView.ViewModel!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        sut = nil
    }


    @MainActor func testSortBreeds_shouldBeInAlphabeticalOrder() async {
        let testBreeds: [Breed] = [
            Breed(name: "Hound", subBreeds: []),
            Breed(name: "African", subBreeds: []),
            Breed(name: "Beagle", subBreeds: []),
        ]
        let sortedBreeds: [Breed] = [
            Breed(name: "African", subBreeds: []),
            Breed(name: "Beagle", subBreeds: []),
            Breed(name: "Hound", subBreeds: []),
        ]
        sut = ContentView.ViewModel(MockService(testBreeds))
        await sut.loadAllBreeds()

        sut.sortBreeds()

        XCTAssertEqual(sortedBreeds, sut.breeds)
    }
    
    @MainActor func testSortBreeds_isEmpty_shouldBeInAlphabeticalOrder() async {
        let testBreeds: [Breed] = []
        let sortedBreeds: [Breed] = []
        sut = ContentView.ViewModel(MockService(testBreeds))
        await sut.loadAllBreeds()

        sut.sortBreeds()

        XCTAssertEqual(sortedBreeds, sut.breeds)
    }
    
    @MainActor func testLoadBreeds_loadTests_shouldBeInAlphabeticalOrder() async {
        let testBreeds: [Breed] = [
            Breed(name: "African", subBreeds: []),
            Breed(name: "Beagle", subBreeds: []),
            Breed(name: "Hound", subBreeds: []),
        ]

        sut = ContentView.ViewModel(MockService(testBreeds))
        await sut.loadAllBreeds()

        sut.sortBreeds()

        XCTAssertEqual(testBreeds, sut.breeds)
    }
    
    @MainActor func testLoadBreeds_loadTests() async {
        let testBreeds: [Breed] = [
            Breed(name: "Beagle", subBreeds: []),
            Breed(name: "Hound", subBreeds: []),
            Breed(name: "African", subBreeds: []),
        ]

        sut = ContentView.ViewModel(MockService(testBreeds))
        await sut.loadAllBreeds()

        sut.sortBreeds()

        XCTAssertNotEqual(testBreeds, sut.breeds)
    }
    
    @MainActor func testFilterBreeds() async {
        let testBreeds: [Breed] = [
            Breed(name: "beagle", subBreeds: []),
            Breed(name: "hound", subBreeds: []),
            Breed(name: "african", subBreeds: []),
        ]

        sut = ContentView.ViewModel(MockService(testBreeds))
        await sut.loadAllBreeds()

        sut.searchText = "H"
        
        sut.filterResults()

        XCTAssertEqual(Breed(name: "hound", subBreeds: []), sut.searchedBreeds.first)
    }
    
    @MainActor func testFilterBreeds_emptyText() async {
        let testBreeds: [Breed] = [
            Breed(name: "Beagle", subBreeds: []),
            Breed(name: "Hound", subBreeds: []),
            Breed(name: "African", subBreeds: []),
        ]

        sut = ContentView.ViewModel(MockService(testBreeds))
        await sut.loadAllBreeds()

        sut.searchText = ""
        
        sut.filterResults()

        XCTAssertTrue(sut.searchedBreeds.contains(Breed(name: "Beagle", subBreeds: [])))
        XCTAssertTrue(sut.searchedBreeds.contains(Breed(name: "Hound", subBreeds: [])))
        XCTAssertTrue(sut.searchedBreeds.contains(Breed(name: "African", subBreeds: [])))
    }
    
    @MainActor func testFilterBreeds_badText() async {
        let testBreeds: [Breed] = [
            Breed(name: "Beagle", subBreeds: []),
            Breed(name: "Hound", subBreeds: []),
            Breed(name: "African", subBreeds: []),
        ]

        sut = ContentView.ViewModel(MockService(testBreeds))
        await sut.loadAllBreeds()

        sut.searchText = "q"
        
        sut.filterResults()

        XCTAssertTrue(sut.searchedBreeds.isEmpty)
    }
}


struct MockService: DogApp.DogServiceProtocol {
    var breeds: [DogApp.Breed] = []

    init(_ breeds: [DogApp.Breed]) {
        self.breeds = breeds
    }

    func getAllBreeds() async throws -> DogApp.BreedResource {
        var breedDictionary: [String: [String]] = [:]
        for breed in breeds {
            breedDictionary[breed.name] = breed.subBreeds
        }
        return DogApp.BreedResource(message: breedDictionary, status: "success")
    }

    func getRandomImage(for breed: DogApp.Breed) async throws -> DogApp.BreedImage {
        BreedImage(message: "", status: "")
    }

    func getSubBreed(for breed: DogApp.Breed) async throws -> DogApp.BreedResource {
        return DogApp.BreedResource(message: [:], status: "")
    }
}

