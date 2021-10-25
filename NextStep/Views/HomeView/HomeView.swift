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
    
    @StateObject private var viewModel = HomeViewModel()

    var body: some View {
        VStack {
            VStack {

                // Steps Section
                NavigationLink(destination: DetailsScreen(
                        title: "Steps",
                        iconName: "figure.walk",
                        secondary_title: "Steps Taken",
                        primary_colour: "steps-primary",
                        secondary_colour: "steps-secondary",
                        startDate_today: viewModel.start_today ?? "No Date",
                        startDate_week: viewModel.start_week ?? "No Date",
                        endDate_week: viewModel.end_week ?? "No Date",
                        value_today: viewModel.pedometerDataToday.steps != nil ? "\(viewModel.pedometerDataToday.steps)" : "0",
                        value_week: viewModel.pedometerDataWeek.steps != nil ? "\(viewModel.pedometerDataWeek.steps)" : "0")) {
                    CardLarge(
                        iconName: "figure.walk",
                        title: "STEPS",
                        description: viewModel.pedometerDataToday.steps != nil ? "\(viewModel.pedometerDataToday.steps)" : "0",
                        primary_colour: "steps-primary",
                        secondary_colour: "steps-secondary",
                        iconSize: 100
                    )
                    .padding(EdgeInsets(top: 15, leading: 15, bottom: 0, trailing: 15))
                }
                .buttonStyle(.plain)
                
                // Energy Burn Section
                NavigationLink(destination: DetailsScreen(
                        title: "Energy Burn",
                        iconName: "flame.fill",
                        secondary_title: "Energy Burned",
                        primary_colour: "energy-burn-primary",
                        secondary_colour: "energy-burn-secondary",
                        startDate_today: viewModel.start_today ?? "No Date",
                        startDate_week: viewModel.start_week ?? "No Date",
                        endDate_week: viewModel.end_week ?? "No Date",
                        value_today: viewModel.pedometerDataToday.energyBurn != nil ? String(format: "%.1f k/cal", viewModel.pedometerDataToday.energyBurn) : "0 k/cal",
                        value_week: viewModel.pedometerDataWeek.energyBurn != nil ? String(format: "%.1f k/cal", viewModel.pedometerDataWeek.energyBurn) : "0 k/cal")) {
                    CardLarge(
                        iconName: "flame.fill",
                        title: "ENERGY BURN",
                        description: viewModel.pedometerDataToday.energyBurn != nil ? String(format: "%.1f k/cal", viewModel.pedometerDataToday.energyBurn) : "0 k/cal",
                        primary_colour: "energy-burn-primary",
                        secondary_colour: "energy-burn-secondary",
                        iconSize: 100
                    )
                    .padding(EdgeInsets(top: 10, leading: 15, bottom: 0, trailing: 15))
                }
                .buttonStyle(.plain)
            }
            
            HStack {
                
                // Distance Section
                NavigationLink(destination: DetailsScreen(
                        title: "Distance",
                        iconName: "ruler",
                        secondary_title: "Distance Travelled",
                        primary_colour: "distance-primary",
                        secondary_colour: "distance-secondary",
                        startDate_today: viewModel.start_today ?? "No Date",
                        startDate_week: viewModel.start_week ?? "No Date",
                        endDate_week: viewModel.end_week ?? "No Date",
                        value_today: viewModel.pedometerDataToday.distance != nil ? String(format: "%.2f km", viewModel.pedometerDataToday.distance) : "0.0 km",
                        value_week: viewModel.pedometerDataWeek.distance != nil ? String(format: "%.2f km", viewModel.pedometerDataWeek.distance) : "0.0 km")) {
                    CardSmall(
                        iconName: "ruler",
                        title: "DISTANCE",
                        description: viewModel.pedometerDataToday.distance != nil ? String(format: "%.2f km", viewModel.pedometerDataToday.distance) : "0.0 km",
                        primary_colour: "distance-primary",
                        secondary_colour: "distance-secondary",
                        iconSize: 50
                    )
                    .padding(EdgeInsets(top: 10, leading: 15, bottom: 15, trailing: 5))
                }
                .buttonStyle(.plain)
                
                // Average Pace Section
                NavigationLink(destination: DetailsScreen(
                        title: "Average Pace",
                        iconName: "stopwatch",
                        secondary_title: "Average Pace",
                        primary_colour: "average-pace-primary",
                        secondary_colour: "average-pace-secondary",
                        startDate_today: viewModel.start_today ?? "No Date",
                        startDate_week: viewModel.start_week ?? "No Date",
                        endDate_week: viewModel.end_week ?? "No Date",
                        value_today: viewModel.pedometerDataToday.averagePace != nil ? String(format: "%.2f m/s", viewModel.pedometerDataToday.averagePace) : "0.0 m/s",
                        value_week: viewModel.pedometerDataWeek.averagePace != nil ? String(format: "%.2f m/s", viewModel.pedometerDataWeek.averagePace) : "0.0 m/s")) {
                    CardSmall(
                        iconName: "stopwatch",
                        title: "AVG. PACE",
                        description: viewModel.pedometerDataToday.averagePace != nil ? String(format: "%.2f m/s", viewModel.pedometerDataToday.averagePace) : "0.0 m/s",
                        primary_colour: "average-pace-primary",
                        secondary_colour: "average-pace-secondary",
                        iconSize: 50
                    )
                    .padding(EdgeInsets(top: 10, leading: 5, bottom: 15, trailing: 15))
                }
                .buttonStyle(.plain)
            }
            .onAppear {
                viewModel.initializePedometer()
            }
        }
        .navigationTitle("Your Steps")
    }
}


