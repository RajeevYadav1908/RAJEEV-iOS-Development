//
//  APIClientsApp.swift
//  APIClients
//
//  Created by Rajeev Yadav on 29/10/26.
//

import Foundation
import SwiftUI

@main
struct APIClientsApp: App {
    @State private var users: [User] = []
    
    let network: NetworkService = URLSessionNetworkService()

    var body: some Scene {
        WindowGroup {
            Text("Total data recieved: \(users.count)")
                .task {
                    await getData()
                }
        }
    }
    
    func getData() async {
        do {
            users = try await network.request(UserEndPoint.users, as: [User].self)
        } catch {
            print("Some error: \(error.localizedDescription)")
        }
    }
}

enum UserEndPoint: Endpoint {
    case users
    
    var baseURL: String { "https://jsonplaceholder.typicode.com" }
    
    var path: String {
        switch self {
        case .users: return "/users"
        }
    }
}

struct User: Codable, Identifiable, Hashable {
    struct Address: Codable, Hashable {
        let city: String
    }
    
    struct Companay: Codable, Hashable {
        let name: String
    }
    
    let id: Int
    let name: String
    let username: String
    let email: String
    let phone: String
    let website: String
    let address: Address
    let company: Companay
}
