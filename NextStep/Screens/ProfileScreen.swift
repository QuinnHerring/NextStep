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
    
    @ObservedObject var database = FirebaseModel()
    
    @State var firstName = ""
    @State var lastName = ""
    @State var age = ""
    @State var height = ""
    @State var weight = ""
    
    private var genderArray = ["Male", "Female", "Other"]
    @State private var selectedGender = "Male"
    
    @FocusState private var nameIsFocused: Bool
    
    // Alerts
    @State private var showingInputAlert = false
    @State private var showingClearAlert = false
    @State private var showingUpdateAlert = false
    
    func readProfile() {
        
        var ref: DatabaseReference!
        ref = Database.database().reference()
        
        // Read First Name
        ref.child("Profile/firstName").getData(completion:  { error, snapshot in
              guard error == nil else {
                print(error!.localizedDescription)
                return;
              }
            
            firstName = snapshot.value as? String ?? "";
        });
        
        // Read Last Name
        ref.child("Profile/lastName").getData(completion:  { error, snapshot in
              guard error == nil else {
                print(error!.localizedDescription)
                return;
              }
            lastName = snapshot.value as? String ?? "";
        });
        
        // Read Age
        ref.child("Profile/age").getData(completion:  { error, snapshot in
              guard error == nil else {
                print(error!.localizedDescription)
                return;
              }
            age = snapshot.value as? String ?? "";
        });
        
        // Read Gender
        ref.child("Profile/gender").getData(completion:  { error, snapshot in
              guard error == nil else {
                print(error!.localizedDescription)
                return;
              }
            selectedGender = snapshot.value as? String ?? "";
        });
        
        // Read Height
        ref.child("Profile/height").getData(completion:  { error, snapshot in
              guard error == nil else {
                print(error!.localizedDescription)
                return;
              }
            height = snapshot.value as? String ?? "";
        });
        
        // Read Weight
        ref.child("Profile/weight").getData(completion:  { error, snapshot in
              guard error == nil else {
                print(error!.localizedDescription)
                return;
              }
            weight = snapshot.value as? String ?? "";
        });
    }
    
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
                }
                
                // Gender Section
                Section(header: Text("Gender")) {
                    // Gender Input
                    Picker(selection: $selectedGender, label: Text("Gender")) {
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
                    TextField("Height", text: $height)
                    .focused($nameIsFocused)
                    .textContentType(.oneTimeCode)
                    .keyboardType(.numberPad)
                    
                    // Weight Input
                    TextField("Weight", text: $weight)
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
                        if (firstName.count == 0 ||
                            lastName.count == 0 ||
                            age.count == 0 ||
                            weight.count == 0 ||
                            height.count == 0)
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
                                
                                self.database.updateProfile(
                                    in_firstName: firstName,
                                    in_lastName: lastName,
                                    in_age: age,
                                    in_selectedGender: selectedGender,
                                    in_height: height,
                                    in_weight: weight
                                )
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
                                self.database.clearProfile()
                                firstName = ""
                                lastName = ""
                                age = ""
                                selectedGender = "Male"
                                height = ""
                                weight = ""
                            }
                        )
                    }
                
                }
            }
        }
        .onAppear {
            print("Appearing")
            readProfile()
            //firstName = self.database.getFirstName()
            
            print("First Name: " + firstName)
        }
        .navigationTitle("Profile")
    }
}

