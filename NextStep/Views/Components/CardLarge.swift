//
//  LargeCard.swift
//  NextStep
//
//  Created by Quinn Herring on 25/10/21.
//

import Foundation
import SwiftUI

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
                    
                    // Text Section
                    VStack(alignment: .leading, spacing: 20) {
                        Text(title)
                            .font(.system(size: 20, design: .rounded))
                            .fontWeight(.black)
                            .foregroundColor(Color(secondary_colour))
                        Text(description)
                            .font(.system(size: 30))
                            .fontWeight(.bold)
                            .foregroundColor(Color.white)
                    }.padding(10)
                    
                    Spacer()
                    
                    // Icon Image
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
