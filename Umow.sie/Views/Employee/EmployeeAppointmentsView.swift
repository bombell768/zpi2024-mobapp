//
//  EmployeesAppointmentsView.swift
//  Umow.sie
//
//  Created by Bartosz Strzecha on 07/12/2024.
//

import SwiftUI

struct EmployeeAppointmentsView: View {
    
    @State var viewModel = AppointmentsHistoryViewModel()
    
    var body: some View {
        NavigationStack {
            ScrollView {
                ForEach(viewModel.sortedDates, id: \.self) { date in
                    if let appointmentsForDate = viewModel.groupedAppointments[date] {
                        AppointmentsDropdownView(
                            appointments: appointmentsForDate,
                            date: date,
                            appointmentsCount: appointmentsForDate.count,
                            isInitiallyExpanded: false
                        )
                    }
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
