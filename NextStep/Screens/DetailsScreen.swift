//
//  StepDetailsScreen.swift
//  NextStep
//
//  Created by Quinn Herring on 20/10/21.
//

import Foundation
import SwiftUI

struct DetailsScreen: View {
    
    var title: String
    
    @State private var timePeriodType = 0
    
    var body: some View {
        
        VStack {
            Picker("What is your favorite color?", selection: $timePeriodType) {
                Text("Daily").tag(0)
                Text("Weekly").tag(1)
                Text("Annually").tag(2)
            }
            .pickerStyle(.segmented)
            
        }
        .navigationTitle(title)
        
    }
    
}
