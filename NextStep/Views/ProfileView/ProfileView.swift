//
//  ProfileScreen.swift
//  NextStep
//
//  Created by Quinn Herring on 20/10/21.
//

import Foundation
import Firebase
import FirebaseDatabase
import SwiftUI

struct ProfileScreen: View {
    
    @StateObject private var viewModel = ProfileViewModel()
    
    private var genderArray = ["Male", "Female", "Other"]
    @State private var selectedGender = "Male"
    
    @FocusState private var nameIsFocused: Bool
    
    // Alerts
    @State private var showingInputAlert = false
    @State private var showingClearAlert = false
    @State private var showingUpdateAlert = false
    
    var body: some View {
        VStack {
            
            Form {
                
                // Personal Info Section
                Section(header: Text("Personal Info")) {
                    
                    // First Name Input
                    TextField("First Name", text: $viewModel.profile.firstName)
                        .focused($nameIsFocused)
                    
                    // Last Name Input
                    TextField("Last Name", text: $viewModel.profile.lastName)
                        .focused($nameIsFocused)
                    
                    // Age Input
                    TextField("Age", text: $viewModel.profile.age)
                        .focused($nameIsFocused)
                        .textContentType(.oneTimeCode)
                        .keyboardType(.numberPad)
                }
                
                // Gender Section
                Section(header: Text("Gender")) {
                    // Gender Input
                    Picker(selection: $viewModel.profile.gender, label: Text("Gender")) {
                        ForEach(genderArray, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.segmented)
                    .onAppear{
                        UISegmentedControl.appearance().selectedSegmentTintColor =  UIColor.init(Color("picker"))
                        }
                }
                
                // Body Info Section
                Section(header: Text("Body Info")) {
                    
                    // Height Input
                    TextField("Height", text: $viewModel.profile.height)
                    .focused($nameIsFocused)
                    .textContentType(.oneTimeCode)
                    .keyboardType(.numberPad)
                    
                    // Weight Input
                    TextField("Weight", text: $viewModel.profile.weight)
                    .focused($nameIsFocused)
                    .textContentType(.oneTimeCode)
                    .keyboardType(.numberPad)
                }
            }
            
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    
                    // Update Button
                    Button(action: {
                        nameIsFocused = false
                        
                        // Check if all details are filled out
                        if (viewModel.profile.firstName.count == 0 ||
                            viewModel.profile.lastName.count == 0 ||
                            viewModel.profile.age.count == 0 ||
                            viewModel.profile.weight.count == 0 ||
                            viewModel.profile.height.count == 0)
                            {
                            // if one detail is empty
                            showingInputAlert = true
                        } else {
                            // all details are filled
                            showingUpdateAlert = true
                        }
                        
                    }, label: {
                        Text("Update")
                    })
                    .alert("Please fill in remaining details", isPresented: $showingInputAlert) {
                                    Button("OK", role: .cancel) { }
                                }
                    .alert(isPresented: $showingUpdateAlert) {
                        Alert(
                            title: Text("Updating Profile"),
                            message: Text("Are you sure?"),
                            primaryButton: .destructive(Text("Cancel")),
                            secondaryButton: .default(Text("Update")) {
                                viewModel.updateProfile()
                            }
                        )
                    }
                    
                    // Clear Button
                    Button(action: {
                        nameIsFocused = false
                        showingClearAlert = true
                    }, label: {
                        Text("Clear")
                    })
                    .alert(isPresented: $showingClearAlert) {
                        Alert(
                            title: Text("Clearing Profile"),
                            message: Text("Are you sure?"),
                            primaryButton: .default(Text("Cancel")),
                            secondaryButton: .destructive(Text("Clear")) {
                                viewModel.clearProfile()
                            }
                        )
                    }
                
                }
            }
        }
        .onAppear {
            viewModel.readProfile()
        }
        .navigationTitle("Profile")
    }
}

