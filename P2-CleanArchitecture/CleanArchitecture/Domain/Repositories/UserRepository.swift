//
//  UserRepository.swift
//  CleanArchitecture
//
//  Created by Rajeev Yadav on 29/10/26.
//

import Foundation

protocol UserRepository {
    func fetchUsers() async throws -> [User]
}
