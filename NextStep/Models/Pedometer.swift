//
//  PedometerModel.swift
//  NextStep
//
//  Created by Quinn Herring on 21/10/21.
//

import Foundation
import SwiftUI
import CoreMotion

// Structure holding pedometer data
struct Pedometer {
    
    let pedometer: CMPedometer = CMPedometer()
    
    var steps: Int
    var energyBurn: Double
    var distance: Double
    var averagePace: Double
}
