//
//  SettingsScreen.swift
//  NextStep
//
//  Created by Quinn Herring on 20/10/21.
//

import Foundation
import SwiftUI

struct SettingsScreen: View {
    
    @AppStorage("isDarkMode") private var isDarkMode = false
    
    var body: some View {
        VStack {
            Form {
                Section(header: Text("Display")) {
                    
                    Toggle("Dark Mode", isOn: $isDarkMode)
                }
            }
        }
        .navigationTitle("Settings")
    }
}
