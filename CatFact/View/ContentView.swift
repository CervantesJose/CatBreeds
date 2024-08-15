//
//  ContentView.swift
//  BreedFact
//
//  Created by Jose Cervantes on 8/14/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var vm = BreedViewModel()
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(vm.breeds, id: \.breed) { breed in
                    NavigationLink(breed.breed) {
                        BreedDetailView(breed: breed)
                    }
                    .listRowSeparator(.hidden)
                }
            }
            .listStyle(.plain)
            .navigationTitle("Cat Breeds")
        }
        .onAppear(perform: vm.fetchData)
        .alert(isPresented: $vm.hasError,
               error: vm.error) {
            Button(action: vm.fetchData) {
                Text("Retry")
            }
        }
    }
}

#Preview {
    ContentView()
}
