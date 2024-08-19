//
//  NetworkManager.swift
//  CatFact
//
//  Created by Jose Cervantes on 8/15/24.
//

import Foundation
import Combine

protocol NetworkProtocol {
    func fetchData<T: Codable>(url: URL) -> AnyPublisher<T, Error>
}

class NetworkManager: NetworkProtocol {
    func fetchData<T>(url: URL) -> AnyPublisher<T, any Error> where T : Codable {
        URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: T.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
