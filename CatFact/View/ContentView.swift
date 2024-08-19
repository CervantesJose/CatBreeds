//
//  ContentView.swift
//  BreedFact
//
//  Created by Jose Cervantes on 8/14/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var vm = BreedViewModel(networkManager: NetworkManager())
    @State private var searchTerm = ""
    
    var filteredCats: [Breed] {
        guard !searchTerm.isEmpty else { return vm.breeds }
        return vm.breeds.filter { $0.breed.localizedCaseInsensitiveContains(searchTerm) }
    }
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(filteredCats, id: \.breed) { breed in
                    NavigationLink(breed.breed) {
                        BreedDetailView(breed: breed)
                    }
                    .listRowSeparator(.hidden)
                }
            }
            .navigationTitle("Cat Breeds")
            .searchable(text: $searchTerm, prompt: "Search Cat Breeds")
            .listStyle(.plain)
        }
        .task {
            vm.getBreeds()
        }.refreshable {
            vm.getBreeds()
        }
    }
}

#Preview {
    ContentView()
}
