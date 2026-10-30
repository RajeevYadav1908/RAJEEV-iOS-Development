//
//  UserServices.swift
//  MVVMProjectDemo
//
//  Created by Rajeev Yadav on 29/10/26.
//

import Foundation

protocol UserService {
    func fetchUsers() async throws -> [User]
}

final class DefaultUserService: UserService {
    private let network: NetworkService
    
    init(network: NetworkService = URLSessionNetworkService()) {
        self.network = network
    }
    
    func fetchUsers() async throws -> [User] {
        try await network.request(UserEndPoint.users, as: [User].self)
    }
}
