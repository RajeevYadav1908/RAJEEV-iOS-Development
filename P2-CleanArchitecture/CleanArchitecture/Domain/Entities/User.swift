//
//  User.swift
//  CleanArchitecture
//
//  Created by Rajeev Yadav on 29/10/26.
//

import Foundation

struct User: Identifiable, Hashable {
    let id: Int
    let name: String
    let username: String
    let email: String
    let phone: String
    let website: String
    let companyName: String
    let city: String
}
