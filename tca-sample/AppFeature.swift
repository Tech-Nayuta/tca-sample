//
//  AppFeature.swift
//  tca-sample
//
//  Created by 化田晃平 on R 3/06/27.
//

import Foundation
import ComposableArchitecture

struct AppState: Equatable {
    var count = 0
    var numberFactAlert: String?
}

struct AppEnvironment {
    var mainQueue: AnySchedulerOf<DispatchQueue>
    var numberFact: (Int) -> Effect<String, APIError>
}

enum AppAction: Equatable {
    case factAlertDismissed
    case decrementButtonTapped
    case incrementButtonTapped
    case numberFactButtonTapped
    case numberFactResponse(Result<String,APIError>)
}

struct APIError: Error, Equatable {}

let appReducer = Reducer<AppState, AppAction, AppEnvironment> { state, action, environment in
    switch action {
    case .factAlertDismissed:
        state.numberFactAlert = nil
        return .none

    case .decrementButtonTapped:
        state.count -= 1
        return .none

    case .incrementButtonTapped:
        state.count += 1
        return .none

    case .numberFactButtonTapped:
        return environment.numberFact(state.count)
            .receive(on: environment.mainQueue)
            .catchToEffect()
            .map(AppAction.numberFactResponse)

    case let .numberFactResponse(.success(fact)):
        state.numberFactAlert = fact
        return .none

    case .numberFactResponse(.failure):
        state.numberFactAlert = "Could not lead a number fact :("
        return .none
    }
}
