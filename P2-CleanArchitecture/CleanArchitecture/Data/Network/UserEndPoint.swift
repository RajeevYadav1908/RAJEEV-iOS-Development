//
//  UserEndPoint.swift
//  CleanArchitecture
//
//  Created by Rajeev Yadav on 29/10/26.
//

import Foundation

enum UserEndPoint: Endpoint {
    case users
    
    var baseURL: String { "https://jsonplaceholder.typicode.com" }
    
    var path: String {
        switch self {
        case .users: return "/users"
        }
    }
}
