//
//  MainView.swift
//  Umow.sie
//
//  Created by Bartosz Strzecha on 20/11/2024.
//

import SwiftUI

struct MainView: View {
    
    @State private var selectedTabIndex = 0
    
    var body: some View {
        TabView(selection: $selectedTabIndex) {
            HomeView()
                .tabItem {
                    Label("Strona główna", systemImage: "house")
                }
                .tag(0)
            
            AppointmentsHistoryView()
                .tabItem {
                    Label("Wizyty", systemImage: "calendar")
                }
                .tag(1)
            
            Text("Profil")
                .tabItem {
                    Label("Profil", systemImage: "person")
                }
                .tag(2)
        }
        .tint(Color.ui.vanilla)
    }
}

#Preview {
    MainView()
}
