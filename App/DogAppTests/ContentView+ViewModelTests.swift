//
//  ContentView+ViewModelTests.swift
//  DogAppTests
//
//  Created by Paul O'Neill on 2022-08-16.
//

import XCTest
@testable import DogApp

@MainActor
class ContentView_ViewModelTests: XCTestCase {
    var sut: ContentView.ViewModel!
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    @MainActor
    override func tearDownWithError() throws {
        sut = nil
    }
    
    func testLoadAllBreeds() async {
        var testBreeds: [Breed] = [
            Breed(name: "hound", subBreeds: []),
            Breed(name: "chewie", subBreeds: []),
            Breed(name: "dobermain", subBreeds: [])
        ]
        
        self.sut = ContentView.ViewModel(MockDogService(testBreeds))
        
        await self.sut.loadAllBreeds()
        
        // Breed count in sut count == test breeds count
        XCTAssertEqual(self.sut.breeds.count, testBreeds.count)
    }
    
    func testLoadAllBreeds_1breed() async {
        var testBreeds: [Breed] = [
            Breed(name: "hound", subBreeds: []),
        ]
        
        self.sut = ContentView.ViewModel(MockDogService(testBreeds))
        
        await self.sut.loadAllBreeds()
        
        // Breed count in sut count == test breeds count
        XCTAssertEqual(self.sut.breeds.count, testBreeds.count)
    }
    
    func testLoadAllBreeds_0breed() async {
        var testBreeds: [Breed] = [
        ]
        
        self.sut = ContentView.ViewModel(MockDogService(testBreeds))
        
        await self.sut.loadAllBreeds()
        
        // Breed count in sut count == test breeds count
        XCTAssertTrue(self.sut.breeds.isEmpty)
    }
    
    func testSortBreeds() async {
        var testBreeds: [Breed] = [
            Breed(name: "hound", subBreeds: []),
            Breed(name: "chewie", subBreeds: []),
            Breed(name: "dobermain", subBreeds: [])
        ]
        
        
        self.sut = ContentView.ViewModel(MockDogService(testBreeds))
        
        await self.sut.loadAllBreeds()
        self.sut.sortBreeds()
        
        // if sorted, then chewie should be first
        XCTAssertEqual(self.sut.breeds.first, testBreeds[1])
        XCTAssertEqual(self.sut.breeds[1], testBreeds[2])
        XCTAssertEqual(self.sut.breeds[2], testBreeds[0])
    }
    
    func testSortBreeds_1Breed() async {
        var testBreeds: [Breed] = [
            Breed(name: "hound", subBreeds: []),
        ]
        
        
        self.sut = ContentView.ViewModel(MockDogService(testBreeds))
        
        await self.sut.loadAllBreeds()
        self.sut.sortBreeds()
        
        // if sorted, then chewie should be first
        XCTAssertEqual(self.sut.breeds.first, testBreeds[0])
    }
    
    func testSortBreeds_0Breed() async {
        var testBreeds: [Breed] = [
        ]
        
        
        self.sut = ContentView.ViewModel(MockDogService(testBreeds))
        
        await self.sut.loadAllBreeds()
        self.sut.sortBreeds()
        
        // if sorted, then chewie should be first
        XCTAssertTrue(self.sut.breeds.isEmpty)
    }

}
