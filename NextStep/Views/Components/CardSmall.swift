//
//  CardSmall.swift
//  NextStep
//
//  Created by Quinn Herring on 25/10/21.
//

import Foundation
import SwiftUI

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
                    // Text Section
                    VStack(alignment: .leading, spacing: 20.0) {
                    Text(title)
                        .font(.system(size: 19, design: .rounded))
                        .fontWeight(.black)
                        .foregroundColor(Color(secondary_colour))
                    Text(description)
                        .font(.system(size: 25))
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
                
                // Icon Image
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
