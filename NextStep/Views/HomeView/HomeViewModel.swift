//
//  HomeViewModel.swift
//  NextStep
//
//  Created by Quinn Herring on 25/10/21.
//

import Foundation
import CoreMotion

final class HomeViewModel: ObservableObject {
    
    @Published var pedometerDataToday = Pedometer(steps: 0, energyBurn: 0, distance: 0, averagePace: 0)
    @Published var pedometerDataWeek = Pedometer(steps: 0, energyBurn: 0, distance: 0, averagePace: 0)
    
    var start_today: String?
    var start_week: String?
    var end_week: String?

    static let taskDateFormat: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter
    }()
    
    // Update UI for today's data
    func updateUI_today(data: CMPedometerData) {
        
        guard let pedometerDistance = data.distance else { return }
        let distanceInMeter = Measurement(value: pedometerDistance.doubleValue, unit: UnitLength.meters)
        
        pedometerDataToday.steps = data.numberOfSteps.intValue
        pedometerDataToday.energyBurn = Double(data.numberOfSteps.intValue) * 0.04
        pedometerDataToday.distance = distanceInMeter.converted(to: .kilometers).value
        pedometerDataToday.averagePace = data.averageActivePace?.doubleValue ?? 0
//        data_today = data
    }
    
    // Update UI for past week's data
    func updateUI_week(data: CMPedometerData) {
        
        guard let pedometerDistance = data.distance else { return }
        let distanceInMeter = Measurement(value: pedometerDistance.doubleValue, unit: UnitLength.meters)
        
        pedometerDataWeek.steps = data.numberOfSteps.intValue
        pedometerDataWeek.energyBurn = Double(data.numberOfSteps.intValue) * 0.04
        pedometerDataWeek.distance = distanceInMeter.converted(to: .kilometers).value
        pedometerDataWeek.averagePace = data.averageActivePace?.doubleValue ?? 0
//        data_week = data
    }
    
    func checkIfPedometerIsAvailable() -> Bool {
        
        if CMPedometer.isPedometerEventTrackingAvailable()
            && CMPedometer.isDistanceAvailable()
            && CMPedometer.isStepCountingAvailable() {
            
            return true
        }
        return false
    }
    
    func initializePedometer() {
        
        // First checks if pedometer information is avaiable
        if checkIfPedometerIsAvailable() {
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .long
            dateFormatter.timeStyle = .none
            
            let calendar = Calendar.current
            
            // Query for today's data
            pedometerDataToday.pedometer.queryPedometerData(from: calendar.startOfDay(for: Date()), to: Date()) { (data, error) in
               
                guard let data = data, error == nil else { return }
                self.updateUI_today(data: data)
                
                self.start_today = dateFormatter.string(from: calendar.startOfDay(for: Date()))
            }
            
            guard let startDate = calendar.date(byAdding: .day, value: -7, to: Date())
            else {
                return
            }

            // Query for past week's data
            pedometerDataWeek.pedometer.queryPedometerData(from: startDate, to: Date()) { (data, error) in
               
                guard let data = data, error == nil else { return }
                self.updateUI_week(data: data)
                
                self.start_week = dateFormatter.string(from: startDate)
                self.end_week = dateFormatter.string(from: Date())
                
            }
        }
    }
    
}
