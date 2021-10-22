//
//  FirebaseModel.swift
//  NextStep
//
//  Created by Quinn Herring on 22/10/21.
//

import Foundation
import Firebase
import FirebaseDatabase

class FirebaseModel: ObservableObject {
    @Published var firstName = ""
    @Published var lastName = ""
    @Published var age = ""
    @Published var selectedGender = ""
    @Published var height = ""
    @Published var weight = ""
  
    // Updates profile data in firebase database
    func updateProfile(
        in_firstName: String,
        in_lastName: String,
        in_age: String,
        in_selectedGender: String,
        in_height: String,
        in_weight: String
    ) {

        var ref: DatabaseReference!
        ref = Database.database().reference()
        ref.child("Profile").setValue([
            "firstName": in_firstName,
            "lastName": in_lastName,
            "age": in_age,
            "gender": in_selectedGender,
            "height": in_height,
            "weight": in_weight
        ])
    }
    
    func getFirstName() -> String {
        return firstName
    }
    
    func readProfile() {
        
        var ref: DatabaseReference!
        ref = Database.database().reference()
        
        // Read First Name
        ref.child("Profile/firstName").getData(completion:  { error, snapshot in
              guard error == nil else {
                print(error!.localizedDescription)
                return;
              }
            
            self.firstName = snapshot.value as? String ?? "";
        });
        
        // Read Last Name
        ref.child("Profile/lastName").getData(completion:  { error, snapshot in
              guard error == nil else {
                print(error!.localizedDescription)
                return;
              }
            self.lastName = snapshot.value as? String ?? "";
        });
        
        // Read Age
        ref.child("Profile/age").getData(completion:  { error, snapshot in
              guard error == nil else {
                print(error!.localizedDescription)
                return;
              }
            self.age = snapshot.value as? String ?? "";
        });
        
        // Read Gender
        ref.child("Profile/gender").getData(completion:  { error, snapshot in
              guard error == nil else {
                print(error!.localizedDescription)
                return;
              }
            self.selectedGender = snapshot.value as? String ?? "";
        });
        
        // Read Height
        ref.child("Profile/height").getData(completion:  { error, snapshot in
              guard error == nil else {
                print(error!.localizedDescription)
                return;
              }
            self.height = snapshot.value as? String ?? "";
        });
        
        // Read Weight
        ref.child("Profile/weight").getData(completion:  { error, snapshot in
              guard error == nil else {
                print(error!.localizedDescription)
                return;
              }
            self.weight = snapshot.value as? String ?? "";
        });
    }
    
    // Clears profile data from firebase database
    func clearProfile() {

        var ref: DatabaseReference!
        ref = Database.database().reference()
        ref.removeValue()
    }
    
}

