//
//  DIContainer.swift
//  CleanArchitecture
//
//  Created by Rajeev Yadav on 29/10/26.
//

import Foundation

@MainActor
final class DIContainer {
    private lazy var networkService: NetworkService = URLSessionNetworkService()
    
    private lazy var userRepository: UserRepository = UserRepositoriesImpl(network: networkService)
    
    private func makeFetchUsersUseCase() -> FetchUserUseCase {
        DefaultFetchUserUseCase(repository: userRepository)
    }
    
    func makeUserListViewModel() -> UserListViewModel {
        UserListViewModel(fetchUsers: makeFetchUsersUseCase())
    }
}
