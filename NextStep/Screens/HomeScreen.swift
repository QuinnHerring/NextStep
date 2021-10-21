//
//  HomeScreen.swift
//  NextStep
//
//  Created by Quinn Herring on 19/10/21.
//

import Foundation
import SwiftUI
import UIKit
import CoreMotion

struct HomeScreen: View {
    
    // MODEL
    private let pedometer: CMPedometer = CMPedometer()
    
    // Today's data
    @State var data_today: CMPedometerData?
    @State var steps_today: Int?
    @State var distance_today: Double?
    @State var averagePace_today: Double?
    @State var start_today: String?
    
    // Past week's data
    @State var data_week: CMPedometerData?
    @State var steps_week: Int?
    @State var distance_week: Double?
    @State var averagePace_week: Double?
    @State var start_week: String?
    @State var end_week: String?
    
    static let taskDateFormat: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter
    }()
    
    private func initializePedometer() {
        
        if isPedometerAvailable {
        
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .long
            dateFormatter.timeStyle = .none
            
            let calendar = Calendar.current
            
            // Query for today's data
            pedometer.queryPedometerData(from: calendar.startOfDay(for: Date()), to: Date()) { (data, error) in
               
                
                guard let data = data, error == nil else { return }
                updateUI_today(data: data)
                
                start_today = dateFormatter.string(from: calendar.startOfDay(for: Date()))
            }
            
            guard let startDate = calendar.date(byAdding: .day, value: -7, to: Date())
            else {
                return
            }

            // Query for past week's data
            pedometer.queryPedometerData(from: startDate, to: Date()) { (data, error) in
               
                guard let data = data, error == nil else { return }
                updateUI_week(data: data)
                
                start_week = dateFormatter.string(from: startDate)
                end_week = dateFormatter.string(from: Date())
                
            }
        }
    }
    
    var isPedometerAvailable: Bool {
        return CMPedometer.isPedometerEventTrackingAvailable() && CMPedometer.isDistanceAvailable() && CMPedometer.isStepCountingAvailable()
    }
    
    // CONTROLLER
    
    // Update UI for today's data
    private func updateUI_today(data: CMPedometerData) {
        
        guard let pedometerDistance = data.distance else { return }
        let distanceInMeter = Measurement(value: pedometerDistance.doubleValue, unit: UnitLength.meters)
        
        steps_today = data.numberOfSteps.intValue
        distance_today = distanceInMeter.converted(to: .kilometers).value
        averagePace_today = data.averageActivePace?.doubleValue
        data_today = data
    }
    
    
    // Update UI for past week's data
    private func updateUI_week(data: CMPedometerData) {
        
        guard let pedometerDistance = data.distance else { return }
        let distanceInMeter = Measurement(value: pedometerDistance.doubleValue, unit: UnitLength.meters)
        
        steps_week = data.numberOfSteps.intValue
        distance_week = distanceInMeter.converted(to: .kilometers).value
        averagePace_week = data.averageActivePace?.doubleValue
        data_week = data
    }
    
    // VIEW
    var body: some View {
        
        VStack {
            VStack {

                NavigationLink(destination: DetailsScreen(
                        title: "Steps",
                        iconName: "figure.walk",
                        secondary_title: "Steps Taken",
                        primary_colour: "steps-primary",
                        secondary_colour: "steps-secondary",
                        startDate_today: start_today ?? "No Date",
                        startDate_week: start_week ?? "No Date",
                        endDate_week: end_week ?? "No Date",
                        value_today: steps_today != nil ? "\(steps_today!)" : "0",
                        value_week: steps_week != nil ? "\(steps_week!)" : "0")) {
                    CardLarge(
                        iconName: "figure.walk",
                        title: "STEPS",
                        description: steps_today != nil ? "\(steps_today!)" : "0",
                        primary_colour: "steps-primary",
                        secondary_colour: "steps-secondary",
                        iconSize: 100
                    )
                    .padding(EdgeInsets(top: 15, leading: 15, bottom: 0, trailing: 15))
                }
                .buttonStyle(.plain)
                
                NavigationLink(destination: DetailsScreen(
                        title: "Energy Burn",
                        iconName: "flame.fill",
                        secondary_title: "Energy Burned",
                        primary_colour: "energy-burn-primary",
                        secondary_colour: "energy-burn-secondary",
                        startDate_today: start_today ?? "No Date",
                        startDate_week: start_week ?? "No Date",
                        endDate_week: end_week ?? "No Date",
                        value_today: "0",
                        value_week: "0")) {
                    CardLarge(
                        iconName: "flame.fill",
                        title: "ENERGY BURN",
                        description: "0 k/cal",
                        primary_colour: "energy-burn-primary",
                        secondary_colour: "energy-burn-secondary",
                        iconSize: 100
                    )
                    .padding(EdgeInsets(top: 10, leading: 15, bottom: 0, trailing: 15))
                }
                .buttonStyle(.plain)
            }
            
            HStack {
                NavigationLink(destination: DetailsScreen(
                        title: "Distance",
                        iconName: "ruler",
                        secondary_title: "Distance Travelled",
                        primary_colour: "distance-primary",
                        secondary_colour: "distance-secondary",
                        startDate_today: start_today ?? "No Date",
                        startDate_week: start_week ?? "No Date",
                        endDate_week: end_week ?? "No Date",
                        value_today: distance_today != nil ? String(format: "%.2f km", distance_today!) : "0.0 km",
                        value_week: distance_week != nil ? String(format: "%.2f km", distance_week!) : "0.0 km")) {
                    CardSmall(
                        iconName: "ruler",
                        title: "DISTANCE",
                        description: distance_today != nil ? String(format: "%.2f km", distance_today!) : "0.0 km",
                        primary_colour: "distance-primary",
                        secondary_colour: "distance-secondary",
                        iconSize: 50
                    )
                    .padding(EdgeInsets(top: 10, leading: 15, bottom: 15, trailing: 5))
                }
                .buttonStyle(.plain)
                
                NavigationLink(destination: DetailsScreen(
                        title: "Average Pace",
                        iconName: "stopwatch",
                        secondary_title: "Average Pace",
                        primary_colour: "average-pace-primary",
                        secondary_colour: "average-pace-secondary",
                        startDate_today: start_today ?? "No Date",
                        startDate_week: start_week ?? "No Date",
                        endDate_week: end_week ?? "No Date",
                        value_today: averagePace_today != nil ? String(format: "%.2f m/s", averagePace_today!) : "0.0 m/s",
                        value_week: averagePace_week != nil ? String(format: "%.2f m/s", averagePace_week!) : "0.0 m/s")) {
                    CardSmall(
                        iconName: "stopwatch",
                        title: "AVG. PACE",
                        description: averagePace_today != nil ? String(format: "%.2f m/s", averagePace_today!) : "0.0 m/s",
                        primary_colour: "average-pace-primary",
                        secondary_colour: "average-pace-secondary",
                        iconSize: 50
                    )
                    .padding(EdgeInsets(top: 10, leading: 5, bottom: 15, trailing: 15))
                }
                .buttonStyle(.plain)
            }
            .onAppear {
                initializePedometer()
            }
        }
        .navigationTitle("Your Steps")
    }
}

struct CardLarge: View {
    var iconName: String
    var title: String
    var description: String
    var primary_colour: String
    var secondary_colour: String
    var iconSize: CGFloat
    
    var body: some View {
        
        HStack(spacing: 20) {
            VStack {
                
                HStack(alignment: .top) {
                    
                    VStack(alignment: .leading, spacing: 20) {
                        Text(title)
                            .font(.system(size: 20, design: .rounded))
                            .fontWeight(.black)
                            .foregroundColor(Color(secondary_colour))
                        Text(description)
                            .font(.system(size: 35))
                            .fontWeight(.bold)
                            .foregroundColor(Color.white)
                    }.padding(10)
                    
                    Spacer()
                    
                    Image(systemName: iconName)
                        .font(.system(size: iconSize))
                        .foregroundColor(Color(secondary_colour))
                        .padding()
                }
                
                Spacer()
            }
        }
        .frame(minWidth: 0, idealWidth: .infinity, maxWidth: .infinity, minHeight: 160, idealHeight: 160, maxHeight: 160, alignment: .top)
        .padding(10)
        .background(Color(primary_colour))
        .cornerRadius(20)
    }
}

struct CardSmall: View {
    var iconName: String
    var title: String
    var description: String
    var primary_colour: String
    var secondary_colour: String
    var iconSize: CGFloat
    
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading) {
                    
                    VStack(alignment: .leading, spacing: 20.0) {
                    Text(title)
                        .font(.system(size: 19, design: .rounded))
                        .fontWeight(.black)
                        .foregroundColor(Color(secondary_colour))

                    Text(description)
                        .font(.system(size: 20))
                        .fontWeight(.bold)
                        .foregroundColor(Color.white)

                    }

                }
                Spacer()
            }
            .padding(10.0)
            Spacer()
            HStack {
                
                Spacer()
                
                Image(systemName: iconName)
                    .font(.system(size: iconSize))
                    .foregroundColor(Color(secondary_colour))
            }
        }
        .frame(minWidth: 0, idealWidth: .infinity, maxWidth: .infinity, minHeight: 160, idealHeight: 160, maxHeight: 160, alignment: .top)
        .padding(10)
        .background(Color(primary_colour))
        .cornerRadius(20)
    }
}


