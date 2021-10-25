//
//  ProfileViewModel.swift
//  NextStep
//
//  Created by Quinn Herring on 25/10/21.
//

import Foundation
import Firebase
import FirebaseDatabase

final class ProfileViewModel: ObservableObject {
    
    @Published var profile = Profile(firstName: "", lastName: "", age: "", gender: "", height: "", weight: "")
    
    // Read Data from Database
    func readProfile() {
        
        var ref: DatabaseReference!
        ref = Database.database().reference()
        
        // Read First Name
        ref.child("Profile/firstName").getData(completion:  { error, snapshot in
              guard error == nil else {
                print(error!.localizedDescription)
                return;
              }
            self.profile.firstName = snapshot.value as? String ?? "";
        });
        
        // Read Last Name
        ref.child("Profile/lastName").getData(completion:  { error, snapshot in
              guard error == nil else {
                print(error!.localizedDescription)
                return;
              }
            self.profile.lastName = snapshot.value as? String ?? "";
        });
        
        // Read Age
        ref.child("Profile/age").getData(completion:  { error, snapshot in
              guard error == nil else {
                print(error!.localizedDescription)
                return;
              }
            self.profile.age = snapshot.value as? String ?? "";
        });
        
        // Read Gender
        ref.child("Profile/gender").getData(completion:  { error, snapshot in
              guard error == nil else {
                print(error!.localizedDescription)
                return;
              }
            self.profile.gender = snapshot.value as? String ?? "Male";
        });
        
        // Read Height
        ref.child("Profile/height").getData(completion:  { error, snapshot in
              guard error == nil else {
                print(error!.localizedDescription)
                return;
              }
            self.profile.height = snapshot.value as? String ?? "";
        });
        
        // Read Weight
        ref.child("Profile/weight").getData(completion:  { error, snapshot in
              guard error == nil else {
                print(error!.localizedDescription)
                return;
              }
            self.profile.weight = snapshot.value as? String ?? "";
        });
    }
    
    
    // Updates profile data in firebase database
    func updateProfile() {

        var ref: DatabaseReference!
        ref = Database.database().reference()
        ref.child("Profile").setValue([
            "firstName": profile.firstName,
            "lastName": profile.lastName,
            "age": profile.age,
            "gender": profile.gender,
            "height": profile.height,
            "weight": profile.weight
        ])
    }
    
    
    // Clears profile data from firebase database
    func clearProfile() {

        //Removes profile node from database
        var ref: DatabaseReference!
        ref = Database.database().reference()
        ref.removeValue()
        
        // Set local profile data to empty
        profile.firstName = ""
        profile.lastName = ""
        profile.age = ""
        profile.gender = "Male"
        profile.height = ""
        profile.weight = ""
    }
}
