//
//  StepDetailsScreen.swift
//  NextStep
//
//  Created by Quinn Herring on 20/10/21.
//

import Foundation
import SwiftUI
import CoreMotion

struct DetailsScreen: View {
    
    var title: String
    var iconName: String
    var secondary_title: String
    var primary_colour: String
    var secondary_colour: String
    var startDate_today : String
    var startDate_week : String
    var endDate_week: String
    var value_today: String
    var value_week: String

    @State private var timePeriodType: TimePeriodType = .today
    
    var body: some View {
        
        // Data period picker
        VStack {
            Picker("", selection: $timePeriodType) {
                ForEach(TimePeriodType.allCases, id: \.self) {
                    Text($0.rawValue)
                }
            }
            .onAppear{
                UISegmentedControl.appearance().selectedSegmentTintColor =  UIColor.init(Color(primary_colour))
            }
            .pickerStyle(.segmented)
            
            
            VStack {
                    
                switch timePeriodType {
                case .today:
                    
                    // Date section
                    Text("Today")
                        .font(.system(size: 20))
                        .fontWeight(.bold)
                        .foregroundColor(Color("base"))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(EdgeInsets(top: 15, leading: 10, bottom: 0, trailing: 0))
                    
                    HStack {
                        Text(" ")
                        Text(startDate_today)
                            .font(.system(size: 18))
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .foregroundColor(Color(primary_colour))
                        Text(" ")
                    }.padding(EdgeInsets(top: 1, leading: 0, bottom: 0, trailing: 0))
                    
                    Divider()
                    
                    // Data section
                    Text(secondary_title)
                        .font(.system(size: 20))
                        .fontWeight(.bold)
                        .foregroundColor(Color("base"))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(EdgeInsets(top: 10, leading: 10, bottom: 0, trailing: 0))
                    
                    Text(value_today)
                        .font(.system(size: 50))
                        .foregroundColor(Color(primary_colour))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 0))
                    
                    Divider()
                    
                    Image(systemName: iconName)
                        .font(.system(size: 150))
                        .foregroundColor(Color(primary_colour))
                        .padding(.top, 50.0)
                    
                case .week:
                    
                    // Date section
                    Text("Between")
                        .font(.system(size: 20))
                        .fontWeight(.bold)
                        .foregroundColor(Color("base"))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(EdgeInsets(top: 15, leading: 10, bottom: 0, trailing: 0))
                    
                    HStack {
                        Text(startDate_week)
                            .font(.system(size: 18))
                            .foregroundColor(Color(primary_colour))
                        
                        Text(" - ")
                            .font(.system(size: 18))
                            .foregroundColor(Color(primary_colour))
                        
                        Text(endDate_week)
                            .font(.system(size: 18))
                            .foregroundColor(Color(primary_colour))
                    }
                    .padding(EdgeInsets(top: 1, leading: 10, bottom: 0, trailing: 0))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Divider()
                    
                    // Data section
                    Text(secondary_title)
                        .font(.system(size: 20))
                        .fontWeight(.bold)
                        .foregroundColor(Color("base"))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(EdgeInsets(top: 10, leading: 10, bottom: 0, trailing: 0))
                    
                    Text(value_week)
                        .font(.system(size: 50))
                        .foregroundColor(Color(primary_colour))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 0))
                   
                    Divider()
                    
                    Image(systemName: iconName)
                        .font(.system(size: 150))
                        .foregroundColor(Color(primary_colour))
                        .padding(.top, 50.0)
                }
            }
            Spacer()
        }
        .padding()
        .navigationTitle(title)
        
    }
    
}

enum TimePeriodType: String, CaseIterable {
    case today = "Today"
    case week = "Past Week"
}
