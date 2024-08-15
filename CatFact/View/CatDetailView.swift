//
//  BreedDetailView.swift
//  BreedFact
//
//  Created by Jose Cervantes on 8/14/24.
//

import SwiftUI

struct BreedDetailView: View {
    var breed: Breed
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                Text("Country: \(breed.country)")
                Text("Origin: \(breed.origin)")
                Text("Coat: \(breed.coat)")
                Text("Pattern: \(breed.pattern)")
            }
            .navigationTitle(breed.breed)
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    BreedDetailView(breed: Breed(breed: "Lola (my cat)", country: "USA", origin: "Depths of Hell", coat: "Brown/Gray", pattern: "Striped"))
}
