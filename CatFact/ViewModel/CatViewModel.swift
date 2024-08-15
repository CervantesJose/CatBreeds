//
//  ViewModel.swift
//  BreedFact
//
//  Created by Jose Cervantes on 8/14/24.
//

import Foundation
import Combine

final class BreedViewModel: ObservableObject {
    @Published var breeds: [Breed] = []
    @Published var hasError = false
    @Published var error: BreedError?
    
    private var bag = Set<AnyCancellable>()
    
    func fetchData() {
        let urlString = "https://catfact.ninja/breeds"
        
        if let url = URL(string: urlString) {
            URLSession
                .shared
                .dataTaskPublisher(for: url)
                .receive(on: DispatchQueue.main)
                .map(\.data)
                .tryMap({ data in
                    let decoder = JSONDecoder()
                    guard let response = try? decoder.decode(Response.self, from: data) else {
                        throw BreedError.failedToDecode
                    }
                    let breeds = response.data

                    return breeds
                })
                .sink { [weak self] res in
                    switch res {
                    case .failure(let error):
                        self?.hasError = true
                        self?.error = BreedError.custom(error: error)
                    default: break
                    }
                } receiveValue: { [weak self] breeds in
                    self?.breeds = breeds
                }
                .store(in: &bag)
        }
    }
}

extension BreedViewModel {
    enum BreedError: LocalizedError {
        case custom(error: Error)
        case failedToDecode
        
        var errorDescription: String? {
            switch self {
            case .failedToDecode:
                return "Failed to decode response"
            case .custom(let error):
                return error.localizedDescription
            }
        }
    }
}
