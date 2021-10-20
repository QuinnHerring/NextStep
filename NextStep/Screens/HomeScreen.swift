//
//  HomeScreen.swift
//  NextStep
//
//  Created by Quinn Herring on 19/10/21.
//

import Foundation
import SwiftUI
import CoreMotion

struct HomeScreen: View {
    
    private let pedometer: CMPedometer = CMPedometer()
    
    @State private var steps: Int?
    @State private var distance: Double?
    @State private var averagePace: Double?
    
    private var isPedometerAvailable: Bool {
        return CMPedometer.isPedometerEventTrackingAvailable() && CMPedometer.isDistanceAvailable() && CMPedometer.isStepCountingAvailable()
    }
    
    
    private func updateUI(data: CMPedometerData) {
        
        steps = data.numberOfSteps.intValue
        guard let pedometerDistance = data.distance else { return }
        
        let distanceInMeter = Measurement(value: pedometerDistance.doubleValue, unit: UnitLength.meters)
        
        distance = distanceInMeter.converted(to: .kilometers).value
        
        averagePace = data.averageActivePace?.doubleValue
    }
    
    private func initializePedometer() {
        
        if isPedometerAvailable {
            
            guard let startDate = Calendar.current.date(byAdding: .day, value: -1, to: Date())
            else {
                return
            }
            
            pedometer.queryPedometerData(from: startDate, to: Date()) { (data, error) in
               
                guard let data = data, error == nil else { return }
                
                updateUI(data: data)
                
            }
        }
    }
    
    
    var body: some View {
        
        VStack {
            VStack {
                NavigationLink(destination: DetailsScreen(title: "STEPS")) {
                    CardLarge(
                        iconName: "figure.walk",
                        title: "STEPS",
                        description: steps != nil ? "\(steps!)" : "0",
                        primary_colour: "steps-primary",
                        secondary_colour: "steps-secondary",
                        iconSize: 100
                    )
                    .padding(EdgeInsets(top: 15, leading: 15, bottom: 0, trailing: 15))
                }
                .buttonStyle(.plain)
                
                NavigationLink(destination: DetailsScreen(title: "ENERGY BURN")) {
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
                NavigationLink(destination: DetailsScreen(title: "DISTANCE")) {
                    CardSmall(
                        iconName: "ruler",
                        title: "DISTANCE",
                        description: distance != nil ? String(format: "%.2f km", distance!) : "0.0 km",
                        primary_colour: "distance-primary",
                        secondary_colour: "distance-secondary",
                        iconSize: 50
                    )
                    .padding(EdgeInsets(top: 10, leading: 15, bottom: 15, trailing: 5))
                }
                .buttonStyle(.plain)
                
                NavigationLink(destination: DetailsScreen(title: "AVERAGE PACE")) {
                    CardSmall(
                        iconName: "stopwatch",
                        title: "AVG. PACE",
                        description: averagePace != nil ? String(format: "%.2f m/s", averagePace!) : "0.0 m/s",
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
        .shadow(color: Color(primary_colour).opacity(0.4), radius: 5, x: 0, y: 5)
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
        .shadow(color: Color(primary_colour).opacity(0.4), radius: 5, x: 0, y: 5)
    }
}


