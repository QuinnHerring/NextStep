//
//  NextStepApp.swift
//  NextStep
//
//  Created by Quinn Herring on 20/10/21.
//

import SwiftUI

@main
struct NextStepApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
