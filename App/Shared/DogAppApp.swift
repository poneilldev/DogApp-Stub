//
//  DogAppApp.swift
//  Shared
//
//  Created by Paul O'Neill on 2022-08-16.
//

import SwiftUI

@main
struct DogAppApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: ContentView.ViewModel(DogService()))
        }
    }
}
