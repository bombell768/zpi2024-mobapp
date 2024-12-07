//
//  EmployeeMainView.swift
//  Umow.sie
//
//  Created by Bartosz Strzecha on 07/12/2024.
//

import SwiftUI

struct EmployeeMainView: View {
    @State private var selectedTabIndex = 0
    
    var body: some View {
        TabView(selection: $selectedTabIndex) {
            AppointmentsHistoryView()
                .tabItem {
                    Label("Wizyty", systemImage: "calendar")
                }
                .tag(0)
            
            AppointmentBookingByEmployeeView()
                .tabItem {
                    Label("Umów", systemImage: "calendar.badge.plus")
                }
                .tag(1)
            
            ProfileView()
                .tabItem {
                    Label("Profil", systemImage: "person")
                }
                .tag(2)
        }
        .tint(Color.ui.vanilla)
    }
}

#Preview {
    EmployeeMainView()
}
