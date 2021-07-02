//
//  CounterFeature.swift
//  tca-sample
//
//  Created by 化田晃平 on R 3/06/27.
//

import Foundation
import ComposableArchitecture

struct CounterState: Equatable {
    var count = 0
}

struct CounterEnvironment {
}

enum CounterAction: Equatable {
    case decrementButtonTapped
    case incrementButtonTapped
}

let counterReducer = Reducer<CounterState, CounterAction, CounterEnvironment> { state, action, environment in
    switch action {
    case .decrementButtonTapped:
        state.count -= 1
        return .none

    case .incrementButtonTapped:
        state.count += 1
        return .none
    }
}
