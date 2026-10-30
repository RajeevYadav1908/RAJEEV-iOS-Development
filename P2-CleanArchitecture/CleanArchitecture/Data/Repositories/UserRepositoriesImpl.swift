//
//  UserRepositoriesImpl.swift
//  CleanArchitecture
//
//  Created by Rajeev Yadav on 29/10/26.
//

import Foundation

final class UserRepositoriesImpl: UserRepository {
    private let network: NetworkService
    
    init(network: NetworkService) {
        self.network = network
    }
    
    func fetchUsers() async throws -> [User] {
        let dtos = try await network.request(UserEndPoint.users, as: [UserDTO].self)
        return dtos.map( { $0.toDomain() })
    }
}
