//
//  FetchUserUseCase.swift
//  CleanArchitecture
//
//  Created by Rajeev Yadav on 29/10/26.
//

import Foundation

protocol FetchUserUseCase {
    func execute() async throws -> [User]
}

final class DefaultFetchUserUseCase: FetchUserUseCase {
    private let repository: UserRepository
    
    init(repository: UserRepository) {
        self.repository = repository
    }
    
    func execute() async throws -> [User] {
        try await repository.fetchUsers().sorted(by: { $0.name < $1.name })
    }
}
