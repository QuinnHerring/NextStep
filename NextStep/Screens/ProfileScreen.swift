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
    @State private var showingInputAlert = false
    @State private var showingClearAlert = false
    
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
                
                Section {
                    Button(action: {
                        if (firstName.count == 0 ||
                            lastName.count == 0 ||
                            age.count == 0 ||
                            weight.count == 0 ||
                            height.count == 0)
                            {
                            showingInputAlert = true
                        } else {
                            print("Updating...")
                        }
                        
                    }, label: {
                        Text("Save Details")
                    })
                    .padding(.trailing)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .alert("Please fill in remaining details", isPresented: $showingInputAlert) {
                                    Button("OK", role: .cancel) { }
                                }
                    
                }
                
            }
            
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    
                    Button(action: {
                            showingClearAlert = true
                    }, label: {
                        Text("Clear")
                    })
                    .padding(.trailing)
                    .alert(isPresented: $showingClearAlert) {
                        Alert(
                            title: Text("Clearing Profile"),
                            message: Text("Are you sure?"),
                            primaryButton: .default(Text("Okay")) {
                                print("Clearing...")
                            },
                            secondaryButton: .destructive(Text("Cancel"))
                        )
                    }
                }
            }
        }
        .navigationTitle("Profile")
    }
}
