//
//  tca_sampleApp.swift
//  tca-sample
//
//  Created by 化田晃平 on R 3/06/27.
//

import SwiftUI
import ComposableArchitecture

@main
struct tca_sampleApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(
                store: Store(
                    initialState: AppState(),
                    reducer: appReducer,
                    environment: AppEnvironment(
                        mainQueue: DispatchQueue.main.eraseToAnyScheduler(),
                        numberFact: { num in
                            Effect(value: "\(num) is a good nuumber Brent")
                        }
                    )
                )
            )
        }
    }
}
