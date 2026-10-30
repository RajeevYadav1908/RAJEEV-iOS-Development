# APIClients

A Swift iOS sample project that demonstrates two common networking approaches for API integration:

- URLSession (Apple’s built-in networking stack)
- Alamofire (popular third-party networking library)

This project is built as a simple, lightweight reference for creating clean API clients with reusable endpoint abstractions and async/await networking.

## Overview

The app fetches a list of users from JSONPlaceholder and demonstrates how to:

- define a reusable `Endpoint` contract
- build HTTP requests
- validate status codes and response data
- decode JSON into Swift models
- handle network errors in a structured way

## Project Structure

```text
APIClients/
├── APIClients.xcodeproj/
├── APIClients/
│   ├── App/
│   │   └── APIClientsApp.swift
│   └── Network/
│       ├── AlamofireNetworkService.swift
│       ├── Endpoint.swift
│       ├── HTTPMethod.swift
│       ├── NetworkError.swift
│       └── URLSessionNetworkService.swift
└── README.md
```

## Core Components

### 1. Endpoint
`Endpoint` is a protocol that defines the request metadata:

- base URL
- path
- HTTP method
- headers
- query items
- request body

It also contains request builder helpers for both networking implementations.

### 2. URLSessionNetworkService
This service uses Apple’s native `URLSession` to perform requests asynchronously.

It includes:

- request building through `Endpoint.makeRequest()`
- async/await data fetching
- HTTP status validation
- JSON decoding
- custom `NetworkError` handling

### 3. AlamofireNetworkService
This service uses Alamofire’s `Session` API to perform the same task with a more developer-friendly interface.

It demonstrates how a library can simplify request handling, validation, and response processing.

### 4. NetworkError
A custom error enum that standardizes common issues such as:

- invalid URL
- invalid response
- unacceptable HTTP status code
- decoding failure
- transport errors

## Example Usage

The app exposes a sample endpoint for fetching users:

```swift
enum UserEndPoint: Endpoint {
    case users

    var baseURL: String { "https://jsonplaceholder.typicode.com" }

    var path: String {
        switch self {
        case .users: return "/users"
        }
    }
}
```

Then the app calls the networking layer:

```swift
let network: NetworkService = URLSessionNetworkService()

users = try await network.request(UserEndPoint.users, as: [User].self)
```

## Supported Features

- async/await request handling
- reusable endpoint abstraction
- JSON decoding with `Codable`
- error encapsulation
- easy comparison between native and library-based networking

## Requirements

- Xcode 15+
- Swift 5.9+
- iOS 17+ (or compatible target)

## URLSession vs Alamofire

### URLSession
Pros:

- built into Apple frameworks, no extra dependency
- lightweight and official
- works well for simple and custom networking needs
- good control over requests, sessions, and caching
- no third-party library maintenance or versioning concerns

Cons:

- more boilerplate code
- less ergonomic than higher-level libraries
- request validation and retry logic require more manual setup
- can feel verbose for common networking patterns

### Alamofire
Pros:

- cleaner and easier-to-read syntax
- powerful request/response helpers and validation
- handles common networking tasks with less boilerplate
- extensive support for retry, authentication, encoding, and interceptors
- very convenient for production-ready API work

Cons:

- adds an external dependency
- introduces more abstraction, which can hide lower-level behavior
- bigger project dependency surface
- may be overkill for very small or simple applications

## Recommendation

Use URLSession when:

- you want a lightweight, dependency-free solution
- the app has simple API needs
- you want to stay closer to Apple’s native networking APIs

Use Alamofire when:

- you want faster development and cleaner APIs
- your app needs advanced request handling, plugins, or validation
- your team prefers a more feature-rich networking abstraction

## Summary

This project is an educational sample that compares two networking approaches in Swift. It is best used as a starting point for understanding request abstractions, clean API design, and how to handle common networking tasks in iOS apps.

## License

This project is distributed under the repository license included in the root of the project.
