//
//  Umow_sieApp.swift
//  Umow.sie
//
//  Created by Bartosz Strzecha on 08/10/2024.
//

import SwiftUI

@main
struct Umow_sieApp: App {
    
    init() {
        UITabBar.appearance().backgroundColor = UIColor.black
        UITabBar.appearance().unselectedItemTintColor = UIColor.white
    }
    
    var body: some Scene {
        WindowGroup {
            EntryView()
                .preferredColorScheme(.dark)
                //.hideKeyboardOnGesture()
        }
    }
}
