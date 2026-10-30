//
//  UserDTO.swift
//  CleanArchitecture
//
//  Created by Rajeev Yadav on 29/10/26.
//

import Foundation

struct UserDTO: Decodable {
    let id: Int
    let name: String
    let username: String
    let email: String
    let phone: String
    let website: String
    let address: Address
    let company: Company
    
    struct Address: Decodable {
        let city: String
    }
    
    struct Company: Decodable {
        let name: String
    }
}

extension UserDTO {
    func toDomain() -> User {
        User(
            id: id,
            name: name,
            username: username,
            email: email,
            phone: phone,
            website: website,
            companyName: company.name,
            city: address.city
        )
    }
}
