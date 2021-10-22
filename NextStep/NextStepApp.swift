//
//  NextStepApp.swift
//  NextStep
//
//  Created by Quinn Herring on 20/10/21.
//

import SwiftUI
import Firebase
import UIKit

@main
struct NextStepApp: App {
    let persistenceController = PersistenceController.shared

    // Create a reference to the App Delegate
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        // Configure FirebaseApp
        FirebaseApp.configure()
        return true
    }
}
