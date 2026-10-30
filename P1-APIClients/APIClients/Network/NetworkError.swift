//
//  NetworkError.swift
//  CleanArchitecture
//
//  Created by Rajeev Yadav on 29/10/26.
//

import Foundation

enum NetworkError: Error, Equatable {
    case invalidURL
    case invalidResponse
    case unacceptableStatusCode(Int)
    case decoding(String)
    case transport(String)
}


extension NetworkError {
    var errorDescription: String {
        switch self {
        case .invalidURL:
            return "The request URL is invalid."
        case .invalidResponse:
            return "The server returned an invalid response."
        case .unacceptableStatusCode(let code):
            return "The server responded with status code \(code)"
        case .decoding(let message):
            return "Failed to decode the response: \(message)"
        case .transport(let message):
            return "Network error: \(message)"
        }
    }
}
