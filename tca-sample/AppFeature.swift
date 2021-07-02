//
//  AppFeature.swift
//  tca-sample
//
//  Created by 化田晃平 on R 3/06/27.
//

import Foundation
import ComposableArchitecture

struct AppState: Equatable {
    var counter1 = CounterState()
    var counter2 = CounterState()
    var numberFactAlert: String?
}

struct AppEnvironment {
    var mainQueue: AnySchedulerOf<DispatchQueue>
    var numberFact: (Int) -> Effect<String, APIError>
}

enum AppAction: Equatable {
    case factAlertDismissed
    case counter1(CounterAction)
    case counter2(CounterAction)
//    case decrementButtonTapped
//    case incrementButtonTapped
    case numberFactButtonTapped
    case numberFactResponse(Result<String,APIError>)
}

struct APIError: Error, Equatable {}

let appReducer = Reducer<AppState, AppAction, AppEnvironment>.combine(
    counterReducer.pullback(
        state: \AppState.counter1,
        action: /AppAction.counter1,
        environment: { _ in CounterEnvironment() }
    ),
    counterReducer.pullback(
        state: \AppState.counter2,
        action: /AppAction.counter2,
        environment: { _ in CounterEnvironment() }
    ),
    .init { state, action, environment in
        switch action {
        case .factAlertDismissed:
            state.numberFactAlert = nil
            return .none

        case .numberFactButtonTapped:
            return environment.numberFact(state.counter1.count + state.counter2.count)
                .receive(on: environment.mainQueue)
                .catchToEffect()
                .map(AppAction.numberFactResponse)

        case let .numberFactResponse(.success(fact)):
            state.numberFactAlert = fact
            return .none

        case .numberFactResponse(.failure):
            state.numberFactAlert = "Could not lead a number fact :("
            return .none
        case .counter1(_):
            return .none
        case .counter2(_):
            return .none
        }
    }
)


