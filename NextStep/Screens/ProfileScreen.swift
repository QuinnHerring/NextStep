//
//  ProfileScreen.swift
//  NextStep
//
//  Created by Quinn Herring on 20/10/21.
//

import Foundation
import SwiftUI

//class FormViewModel: ObservableObject {
//
//}

struct ProfileScreen: View {
    
    //@StateObject var viewModel = FormViewModel()
    
    @State var firstName = ""
    @State var lastName = ""
    @State var age = ""
    @State var height = ""
    @State var weight = ""
    @State var gender = ""
    
    private var genderArray = ["Male", "Female", "Other"]
    @State private var selectedIndex = 0
    
    @FocusState private var nameIsFocused: Bool
    
    var body: some View {
        VStack {
            
            Form {
                
                // Personal Info Section
                Section(header: Text("Personal Info")) {
                    
                    // First Name Input
                    TextField("First Name", text: $firstName)
                        .focused($nameIsFocused)
                    
                    // Last Name Input
                    TextField("Last Name", text: $lastName)
                        .focused($nameIsFocused)
                    
                    // Age Input
                    TextField("Age", text: $age)
                        .focused($nameIsFocused)
                        .textContentType(.oneTimeCode)
                        .keyboardType(.numberPad)
                    
                    // Gender Input
                    Picker(selection: $selectedIndex, label: Text("Gender")) {
                        ForEach(0 ..< genderArray.count) {
                            Text(self.genderArray[$0])
                        }
                    }
                }
                
                // Body Info Section
                Section(header: Text("Body Info")) {
                    
                    // Height Input
                    TextField("Height", text: $height)
                    .textContentType(.oneTimeCode)
                    .keyboardType(.numberPad)
                    
                    // Weight Input
                    TextField("Weight", text: $weight)
                    .textContentType(.oneTimeCode)
                    .keyboardType(.numberPad)
                }
                
                Button {
                    print("Button pressed")
                } label: {
                    Text("Press Me")
                        .padding(20)
                }
                .frame(maxWidth: .infinity, alignment: .center)
                
            }
            
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    
                    Button(action: {
                        print("HEY")
                        if (firstName.count == 0 ||
                            lastName.count == 0 ||
                            age.count == 0 ||
                            weight.count == 0 ||
                            height.count == 0)
                            {
                            print("HEY")
                        }
                        
                    }, label: {
                        Text("Clear")
                    }).padding(.trailing)
                    
                    
                }
            }
        }
        .navigationTitle("Profile")
    }
}
