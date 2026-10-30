//
//  User.swift
//  MVVMProjectDemo
//
//  Created by Rajeev Yadav on 29/10/26.
//

import Foundation

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
