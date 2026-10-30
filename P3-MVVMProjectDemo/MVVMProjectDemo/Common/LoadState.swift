//
//  LoadState.swift
//  CleanArchitecture
//
//  Created by Rajeev Yadav on 29/10/26.
//

import Foundation

enum LoadState<Value> {
    case idle
    case loading
    case loaded(Value)
    case failed(String)
    
    var isLoaded: Bool {
        if case .loaded = self { true } else { false }
    }
}

extension LoadState: Equatable where Value: Equatable {}
