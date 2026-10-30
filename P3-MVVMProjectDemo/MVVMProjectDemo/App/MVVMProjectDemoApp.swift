//
//  MVVMProjectDemoApp.swift
//  MVVMProjectDemo
//
//  Created by Rajeev Yadav on 29/10/26.
//

import SwiftUI

@main
struct MVVMProjectDemoApp: App {
    var body: some Scene {
        WindowGroup {
            UserListView(viewModel: UserListViewModel())
        }
    }
}
