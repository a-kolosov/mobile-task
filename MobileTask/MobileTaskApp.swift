//
//  MobileTaskApp.swift
//  MobileTask
//
//  Created by Anton on 21/02/24.
//

import SwiftUI

@main
struct MobileTaskApp: App {
    var body: some Scene {
        WindowGroup {
            EventsView(viewModel: EventsViewModel(events: [], networkManager: NetworkManager()))
        }
    }
}
