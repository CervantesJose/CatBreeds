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
    @Published var error: NetworkError?
    
    private var bag = Set<AnyCancellable>()
    
    func getBreeds(urlString: String) async {
//        let networkManager = NetworkManager()
        if let url = URL(string: urlString) {
            URLSession
                .shared
                .dataTaskPublisher(for: url)
                .receive(on: DispatchQueue.main)
                .map(\.data)
                .tryMap({ data in
                    let decoder = JSONDecoder()
                    guard let response = try? decoder.decode(Response.self, from: data) else {
                        throw NetworkError.failedToDecode
                    }
                    let breeds = response.data

                    return breeds
                })
                .sink { [weak self] res in
                    switch res {
                    case .failure(let error):
                        self?.error = NetworkError.custom(error: error)
                    default: break
                    }
                } receiveValue: { [weak self] breeds in
                    self?.breeds = breeds
                }
                .store(in: &bag)
        }
    }
}
