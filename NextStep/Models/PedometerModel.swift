//
//  PedometerModel.swift
//  NextStep
//
//  Created by Quinn Herring on 21/10/21.
//

import Foundation
import SwiftUI
import CoreMotion

struct PedometerModel {
    
    let pedometer: CMPedometer = CMPedometer()
    
    @State var steps: Int?
    @State var distance: Double?
    @State var averagePace: Double?
    
    var isPedometerAvailable: Bool {
        return CMPedometer.isPedometerEventTrackingAvailable() && CMPedometer.isDistanceAvailable() && CMPedometer.isStepCountingAvailable()
    }
    
    func updateUI(data: CMPedometerData) {
        
        steps = data.numberOfSteps.intValue

        
        print(data)
        print(steps != nil ? "\(steps!)" : "0")
        
        guard let pedometerDistance = data.distance else { return }
        
        let distanceInMeter = Measurement(value: pedometerDistance.doubleValue, unit: UnitLength.meters)
        
        distance = distanceInMeter.converted(to: .kilometers).value
        
        averagePace = data.averageActivePace?.doubleValue
    }
    
    func initializePedometer() {
        
        if isPedometerAvailable {
            
            let calendar = Calendar.current
            
            pedometer.queryPedometerData(from: calendar.startOfDay(for: Date()), to: Date()) { (data, error) in
               
                guard let data = data, error == nil else { return }
                
                updateUI(data: data)
                
            }
        }
    }
}
