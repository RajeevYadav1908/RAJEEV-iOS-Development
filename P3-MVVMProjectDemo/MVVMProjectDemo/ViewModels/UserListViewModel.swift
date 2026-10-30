//
//  UserListViewModel.swift
//  CleanArchitecture
//
//  Created by Rajeev Yadav on 29/10/26.
//

import Foundation
import Observation

@MainActor
@Observable
final class UserListViewModel {
    private(set) var state: LoadState<[User]> = .idle
    
    @ObservationIgnored
    private let service: UserService
    
    init(service: UserService = DefaultUserService()) {
        self.service = service
    }
    
    func load() async {
        state = .loading
        do {
            let users = try await service.fetchUsers()
            state = .loaded(users.sorted(by: { $0.name < $1.name }))
        } catch {
            state = .failed(error.localizedDescription)
        }
    }
}
