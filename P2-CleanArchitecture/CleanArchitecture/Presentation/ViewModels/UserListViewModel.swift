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
    private let fetchUsers: FetchUserUseCase
    
    init(fetchUsers: FetchUserUseCase) {
        self.fetchUsers = fetchUsers
    }
    
    func load() async {
        state = .loading
        do {
            state = .loaded(try await fetchUsers.execute())
        } catch {
            state = .failed(error.localizedDescription)
        }
    }
}
