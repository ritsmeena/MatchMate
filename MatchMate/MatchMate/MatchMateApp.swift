//
//  MatchMateApp.swift
//  MatchMate
//
//  Created by Ritika Meena on 11/02/25.
//

import SwiftUI

@main
struct MatchMateApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            DashboardScreen()
                .environment(\.managedObjectContext, persistenceController.viewContext)

        }
    }
}
