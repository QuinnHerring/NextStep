//
//  SettingsScreen.swift
//  NextStep
//
//  Created by Quinn Herring on 20/10/21.
//

import Foundation
import SwiftUI

struct SettingsScreen: View {
    
    var body: some View {
        VStack {
            Form {
                Section(header: Text("Display")) {
                    
                    Toggle(isOn: .constant(true),
                           label: {
                        Text("Dark Mode")
                    })
                }
            }
        }
        .navigationTitle("Settings")
    }
}
