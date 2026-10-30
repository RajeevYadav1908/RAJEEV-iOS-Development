//
//  Endpoint.swift
//  CleanArchitecture
//
//  Created by Rajeev Yadav on 29/10/26.
//

import Alamofire
import Foundation

protocol Endpoint {
    var baseURL: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var headers: [String: String] { get }
    var queryItems: [URLQueryItem] { get }
    var body: Data? { get }
}

// URLSession Setup
extension Endpoint {
    var method: HTTPMethod { .get }
    var headers: [String: String] { ["Accept" : "application/json"] }
    var queryItems: [URLQueryItem] { [] }
    var body: Data? { nil }
    
    
    func makeRequest() throws -> URLRequest {
        guard var components = URLComponents(string: baseURL + path) else {
            throw NetworkError.invalidURL
        }
        
        if !queryItems.isEmpty {
            components.queryItems = queryItems
        }
        
        guard let url = components.url else {
            throw NetworkError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.httpBody = body
        headers.forEach { request.setValue($1, forHTTPHeaderField: $0) }
        return request
    }
}

// Alamofire setup
extension Endpoint {
    func makeAlamoRequest() throws -> URLRequest {
        let urlString = self.baseURL + self.path
        guard let url = URL(string: urlString) else {
            throw NetworkError.invalidURL
        }
        
        let method = alamofireHTTPMethod(from: self.method)
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.allHTTPHeaderFields = self.headers
        
        if let body = self.body, method != .get {
            request.httpBody = body
        }

        return request
    }
    
    private func alamofireHTTPMethod(from method: HTTPMethod) -> Alamofire.HTTPMethod {
        switch method {
        case .get: return .get
        case .post: return .post
        case .put: return .put
        case .patch: return .patch
        case .delete: return .delete
        }
    }
}
