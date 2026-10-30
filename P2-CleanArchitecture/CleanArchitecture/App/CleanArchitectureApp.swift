//
//  CleanArchitectureApp.swift
//  CleanArchitecture
//
//  Created by Rajeev Yadav on 22/10/26.
//

import SwiftUI

@main
struct CleanArchitectureApp: App {
    private let container = DIContainer()
    
    var body: some Scene {
        WindowGroup {
            UserListView(viewModel: container.makeUserListViewModel())
        }
    }
}
