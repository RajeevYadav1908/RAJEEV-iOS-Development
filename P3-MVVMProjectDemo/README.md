# RAJEEV-iOS-Development

This repository contains iOS projects and demos focused on clean app architecture, networking, and SwiftUI development. The `MVVMArchitectureDemo` branch demonstrates a practical Model-View-ViewModel (MVVM) implementation in SwiftUI.

## MVVM Architecture Demo

This project follows the MVVM pattern to separate responsibilities and keep the UI simple, testable, and maintainable.

### 1. Model
The `Models` layer defines the raw data structure used by the app.

- `User.swift` contains the `User` model.
- It represents data returned from the API and conforms to `Codable`, `Identifiable`, and `Hashable`.
- This layer is responsible only for data representation and does not handle UI logic or fetching logic.

### 2. View
The `Views` layer is responsible for rendering the user interface.

- `UserListView.swift` is the SwiftUI screen that displays the list of users.
- It observes the `ViewModel` state and renders different states such as:
  - idle
  - loading
  - loaded
  - failed
- The view is intentionally "dumb" from a business logic perspective; it focuses on how data is displayed.

### 3. ViewModel
The `ViewModels` layer acts as the bridge between the UI and business logic.

- `UserListViewModel.swift` owns the screen state through `LoadState<[User]>`.
- It calls the service to fetch users asynchronously.
- It transforms the raw data into a UI-friendly state and exposes it to the view.
- This layer handles loading, success, and error states without directly depending on the UI.

### 4. Service Layer
The `Services` layer encapsulates app-specific data access logic.

- `UserService.swift` defines the `UserService` protocol and `DefaultUserService` implementation.
- The service calls the network layer and returns the decoded user array.
- `UserEndPoint.swift` defines the endpoint for fetching users from JSONPlaceholder.

### 5. Network Layer
The `Network` layer handles all HTTP requests and parsing.

- `Endpoint.swift` defines the endpoint contract and request-building logic.
- `HTTPMethod.swift` defines request methods.
- `NetworkError.swift` defines custom networking errors.
- `NetworkService.swift` performs the actual URLSession request, checks status codes, and decodes JSON into the required model type.

### 6. Common / Shared State
The `Common` folder contains reusable app state structures.

- `LoadState.swift` defines a generic state enum used by the ViewModel.
- This helps keep UI state explicit and consistent across screens.

## Data Flow in MVVM

The flow of this project is:

1. `MVVMProjectDemoApp` launches the app and presents `UserListView`.
2. `UserListView` triggers `viewModel.load()` inside `.task`.
3. `UserListViewModel` updates state to `.loading`.
4. The ViewModel requests data from `DefaultUserService`.
5. The service calls `URLSessionNetworkService`.
6. The network layer sends the request to the API and decodes the response.
7. The ViewModel receives the users and updates state to `.loaded(users)`.
8. The view re-renders UI based on the newest state.

This separation keeps the app modular and makes it easier to scale as features grow.

## Project Structure

```text
MVVMProjectDemo/
├── App/
│   └── MVVMProjectDemoApp.swift
├── Common/
│   └── LoadState.swift
├── Models/
│   └── User.swift
├── Network/
│   ├── Endpoint.swift
│   ├── HTTPMethod.swift
│   ├── NetworkError.swift
│   └── NetworkService.swift
├── Services/
│   ├── UserEndPoint.swift
│   └── UserService.swift
├── ViewModels/
│   └── UserListViewModel.swift
├── Views/
│   └── UserListView.swift
└── xcodeproj/
```

## Why this is MVVM

This demo is a clean example of MVVM because:

- The `View` only renders UI and forwards user actions.
- The `ViewModel` contains screen logic and state management.
- The `Model` represents data.
- The `Service` and `Network` layers are responsible for data fetching and API communication.
- The architecture reduces direct coupling between UI and network code.

## API Used

The project fetches sample user data from:

- https://jsonplaceholder.typicode.com/users

This is a public mock API used for demo and learning purposes.

## Summary

The MVVMArchitectureDemo branch is a beginner-friendly SwiftUI project that demonstrates how to organize code using MVVM, service abstraction, and a clean networking layer. It is a good starting point for learning app architecture in iOS development.
