//
//  NetworkService.swift
//  CleanArchitecture
//
//  Created by Rajeev Yadav on 29/10/26.
//

import Foundation

protocol NetworkService {
    func request<T: Decodable>(_ endpoint: any Endpoint, as type: sending T.Type) async throws -> T
}

final class URLSessionNetworkService: NetworkService {
    private let session: URLSession
    private let decoder: JSONDecoder
    
    init(session: URLSession = .shared, decoder: JSONDecoder = JSONDecoder()) {
        self.session = session
        self.decoder = decoder
    }
    
    func request<T: Decodable>(_ endpoint: any Endpoint, as type: sending T.Type = T.self) async throws -> T {
        let request = try endpoint.makeRequest()
        
        let data: Data
        let response: URLResponse
        
        do {
            (data, response) = try await session.data(for: request)
        } catch {
            throw NetworkError.transport(error.localizedDescription)
        }
        
        guard let http = response as? HTTPURLResponse else {
            throw NetworkError.invalidResponse
        }
        
        guard (200..<300).contains(http.statusCode) else {
            throw NetworkError.unacceptableStatusCode(http.statusCode)
        }
        
        do {
            return try decoder.decode(T.self, from: data)
        } catch {
            throw NetworkError.decoding(String(describing: error))
        }
    }
}

