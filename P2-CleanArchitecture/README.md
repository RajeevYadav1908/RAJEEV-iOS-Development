# RAJEEV-iOS-Development

This repository contains iOS projects and demos focused on architecture, SwiftUI, networking, and clean app design. The `CleanArchitectureDemo` branch demonstrates a practical implementation of Clean Architecture in SwiftUI.

## Clean Architecture Demo

This project follows Clean Architecture principles to organize code into distinct layers with clear responsibilities. The goal is to keep the UI independent from business logic and to isolate data access details behind well-defined interfaces.

### 1. Presentation Layer
The `Presentation` layer contains the UI and screen state logic.

- `Presentation/Views/UserListView.swift` renders the user interface.
- `Presentation/ViewModels/UserListViewModel.swift` manages the screen state and handles data loading results.
- `Presentation/Common/LoadState.swift` defines a reusable state representation for loading, success, and error states.

This layer depends on the domain layer but does not know how data is fetched or how network requests are implemented.

### 2. Domain Layer
The `Domain` layer contains the business rules and core application logic.

- `Domain/Entities/User.swift` defines the business model for a user.
- `Domain/Repositories/UserRepository.swift` is the repository contract that describes how user data is accessed.
- `Domain/Usecases/FetchUserUseCase.swift` contains the use case that sorts and returns users.

This layer is independent of SwiftUI and infrastructure code. It defines what the app needs, not how it is implemented.

### 3. Data Layer
The `Data` layer implements repository logic and transforms external data into domain models.

- `Data/Repositories/UserRepositoriesImpl.swift` implements `UserRepository`.
- `Data/DTOs/UserDTO.swift` maps API responses into a data transfer object.
- `Data/Network/UserEndPoint.swift` defines the API endpoint for users.

This layer bridges the domain and the infrastructure. It converts raw API data into the app’s domain model.

### 4. Core / Infrastructure Layer
The `Core/Network` folder contains the networking infrastructure used by the data layer.

- `Endpoint.swift` defines the request contract.
- `HTTPMethod.swift` defines supported HTTP methods.
- `NetworkError.swift` handles API and request errors.
- `NetworkService.swift` performs `URLSession` requests and JSON decoding.

This layer is responsible for technical details such as HTTP communication, decoding, and error handling.

### 5. App / Composition Root
The `App` folder wires everything together.

- `DIContainer.swift` acts as the composition root.
- It creates the network service, repository, and use case.
- It injects the correct dependencies into the ViewModel.

This is where the actual application assembly happens.

## Dependency Rule

Clean Architecture enforces the following direction:

- Presentation → Domain
- Domain → Data (via abstraction/protocols)
- Data → Infrastructure

Important rule:

- Outer layers depend on inner layers.
- Inner layers do not know about UI frameworks or transport details.
- Dependencies flow inward through interfaces rather than concrete implementations.

## Runtime Flow

The flow of data in this project is:

1. `CleanArchitectureApp` launches the app.
2. `DIContainer` creates the required services and dependencies.
3. `UserListView` creates `UserListViewModel` with the `FetchUserUseCase`.
4. The ViewModel calls `fetchUsers.execute()` when the view appears.
5. The use case delegates to `UserRepository`.
6. The repository calls the network service and fetches `UserDTO` data.
7. The DTO is converted to the domain `User` model.
8. The ViewModel updates its state to `.loaded` or `.failed`.
9. The view renders the new state.

This keeps the app easier to test, maintain, and extend.

## Project Structure

```text
CleanArchitecture/
├── App/
│   ├── CleanArchitectureApp.swift
│   └── DIContainer.swift
├── Core/
│   └── Network/
│       ├── Endpoint.swift
│       ├── HTTPMethod.swift
│       ├── NetworkError.swift
│       └── NetworkService.swift
├── Data/
│   ├── DTOs/
│   │   └── UserDTO.swift
│   ├── Network/
│   │   └── UserEndPoint.swift
│   └── Repositories/
│       └── UserRepositoriesImpl.swift
├── Domain/
│   ├── Entities/
│   │   └── User.swift
│   ├── Repositories/
│   │   └── UserRepository.swift
│   └── Usecases/
│       └── FetchUserUseCase.swift
├── Presentation/
│   ├── Common/
│   │   └── LoadState.swift
│   ├── ViewModels/
│   │   └── UserListViewModel.swift
│   └── Views/
│       └── UserListView.swift
└── xcodeproj/
```

## Why this is Clean Architecture

This demo is a good example of Clean Architecture because:

- The UI is separated from the business logic.
- Data access is abstracted through repository interfaces.
- Business rules live in the domain layer.
- Network and external frameworks are isolated in infrastructure code.
- Dependencies are injected at the composition root instead of being hardwired.

## API Used

The app fetches sample user data from:

- https://jsonplaceholder.typicode.com/users

This is a public mock API used for learning and demo purposes.

## Summary

The `CleanArchitectureDemo` branch provides a clean, beginner-friendly example of how to structure an iOS app using Clean Architecture. It separates UI, business rules, data access, and networking into reusable layers, making the codebase easier to understand and scale.
