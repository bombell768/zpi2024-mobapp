//
//  EmployeesAppointmentsView.swift
//  Umow.sie
//
//  Created by Bartosz Strzecha on 07/12/2024.
//

import SwiftUI

struct EmployeeAppointmentsView: View {
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    AppointmentsDropdownView()
                }
                .padding(.top)
                .navigationTitle("Wizyty")
            }
        }
    }
}

#Preview {
    EmployeeAppointmentsView()
}
