//
//  ProfileScreen.swift
//  NextStep
//
//  Created by Quinn Herring on 20/10/21.
//

import Foundation
import SwiftUI

struct ProfileScreen: View {
    
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var age = ""
    @State private var height = ""
    @State private var weight = ""
    @State private var gender = ""
    
    var body: some View {
        VStack {
            
            Form {
                Section(header: Text("Personal Info")) {
                    TextField("First Name", text: $firstName)
                    TextField("Last Name", text: $lastName)
                    TextField("Age", text: $age)
                    TextField("Gender", text: $gender)
                }
                Section(header: Text("Body Info")) {
                    TextField("Height", text: $height)
                    TextField("Weight", text: $weight)
                }
            }
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    
                    Button(action: {
                        
                    }, label: {
                        Text("Edit")
                    })
                    
                    Button(action: {
                        
                    }, label: {
                        Image(systemName: "trash")
                    })
                    
                    
                }
            }
        }
        .navigationTitle("Profile")
    }
}
