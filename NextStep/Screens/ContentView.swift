//
//  ContentView.swift
//  NextStep
//
//  Created by Quinn Herring on 19/10/21.
//

import SwiftUI

struct ContentView: View {
    
    init() {
            //Use this if NavigationBarTitle is with Large Font
        UINavigationBar.appearance().largeTitleTextAttributes = [
            .foregroundColor: UIColor.init(Color("base"))
        ]
    }
    
    @AppStorage("isDarkMode") private var isDarkMode = false

    @State var selectedIndex = 0
    
    let icons = [
        "heart.text.square.fill",
        "person.fill",
        "gear",
    ]
    
    var body: some View {
        
        VStack(spacing: 0) {
            ZStack {
                switch selectedIndex{
                case 0:
                    NavigationView {
                        HomeScreen()
                    }
                case 1:
                    NavigationView {
                        ProfileScreen()
                    }
                default:
                    NavigationView {
                        SettingsScreen()
                    }
                }
            }
            

            HStack {
                ForEach(0..<3, id: \.self) { number in
                    Spacer()
                    Button(action: {
                        self.selectedIndex = number
                    }, label: {
                        
                        Image(systemName: icons[number])
                            .font(.system(size: 25, weight: .regular, design: .default))
                            .foregroundColor(selectedIndex == number ? Color("base") : Color(UIColor.lightGray))
                    }).padding()
                    Spacer()
                }
            }
            .padding(0.0)
        }
        }
}

struct ContentView_Previews: PreviewProvider {
    
    @AppStorage("isDarkMode") static var isDarkMode = false
    
    static var previews: some View {
        ContentView().preferredColorScheme(isDarkMode ? .dark : .light)
            
    }
}
