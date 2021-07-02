//
//  CounterView.swift
//  tca-sample
//
//  Created by 化田晃平 on R 3/06/27.
//

import SwiftUI
import ComposableArchitecture

struct CounterView: View {
    let store: Store<CounterState, CounterAction>
    var body: some View {
        WithViewStore(store) { viewStore in
            HStack {
                Button("-") { viewStore.send(.decrementButtonTapped)
                }
                Text("\(viewStore.count)")
                Button("+") { viewStore.send(.incrementButtonTapped)
                }
            }
        }
    }
}

struct CounterView_Previews: PreviewProvider {
    static var previews: some View {
        CounterView(
            store: Store(
                initialState: CounterState(),
                reducer: counterReducer,
                environment: CounterEnvironment()
            )
        )
    }
}
