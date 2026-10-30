//
//  UserListView.swift
//  CleanArchitecture
//
//  Created by Rajeev Yadav on 29/10/26.
//

import SwiftUI

struct UserListView: View {
    @State private var viewModel: UserListViewModel
    
    init(viewModel: UserListViewModel) {
        _viewModel = State(initialValue: viewModel)
    }
    
    var body: some View {
        NavigationStack {
            content
        }
        .task {
            await viewModel.load()
        }
    }
    
    @ViewBuilder
    private var content: some View {
        switch viewModel.state {
        case .idle, .loading:
            ProgressView("Loading Users...")
        case .failed(let message):
            ContentUnavailableView {
                Label("Something went wrong", systemImage: "exclamationmark.triangle")
            } description: {
                Text(message)
            } actions: {
                Button("Retry") { Task { await viewModel.load() }}
            }
        case .loaded(let users):
            List(users) { user in
                NavigationLink(value: user) {
                    UserRowView(user: user)
                }
            }
        }
    }
}

private struct UserRowView: View {
    let user: User
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(user.name)
                .font(.headline)
            Text(user.email)
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
    }
}
