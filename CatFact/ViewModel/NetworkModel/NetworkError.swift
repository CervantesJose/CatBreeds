//
//  NetworkError.swift
//  CatFact
//
//  Created by Jose Cervantes on 8/15/24.
//

import Foundation

enum NetworkError: Error {
    case custom(error: Error)
    case failedToDecode
}

extension NetworkError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .failedToDecode:
            return "Failed to decode response"
        case .custom(let error):
            return error.localizedDescription
        }
    }
}
