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
    let networkManager: NetworkProtocol
    
    init(networkManager: NetworkProtocol) {
        self.networkManager = networkManager
    }
    
    func getBreeds() {
        guard let url = URL(string: APIEndPoints.CatAPIEndPoint) else { return }
        networkManager.fetchData(url: url)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                print(completion)
            } receiveValue: { (response: Response) in
                self.breeds = response.data
            }
            .store(in: &bag)

    }
}
