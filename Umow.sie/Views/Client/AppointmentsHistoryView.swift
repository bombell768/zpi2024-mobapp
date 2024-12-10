//
//  AppointmentsHistoryView.swift
//  Umow.sie
//
//  Created by Bartosz Strzecha on 20/11/2024.
//

import SwiftUI

struct AppointmentsHistoryView: View {
    
    @AppStorage("userID") private var clientID: Int?
    @AppStorage("userRole") private var userRole: UserRole?
    
    @State private var viewModel = AppointmentsHistoryViewModel()
    
    
    
    var body: some View {
        
        NavigationStack {
            ScrollView {
//                VStack(alignment: .leading) {
//                    Text("Wizyty")
//                        .font(.largeTitle)
//                        .fontWeight(.semibold)
//                    
//                }
//                .frame(minWidth: 0, maxWidth: .infinity, alignment: .topLeading)
//                .padding()
                
                HStack {
                    Button {
                        viewModel.selectedStatus = .reserved
                        viewModel.filterAppointments()
                    } label: {
                        HStack {
                            Text("Umówione")
                                .fontWeight(.semibold)
                        }
                        .foregroundColor(viewModel.selectedStatus == .reserved ? .black.opacity(0.9) : .white)
                        .padding()
                    }
                    .background(viewModel.selectedStatus == .reserved ? Color.ui.vanilla : Color.ui.cultured.opacity(0.9))
                    .cornerRadius(40)
                    
                    Button {
                        viewModel.selectedStatus = .done
                        viewModel.filterAppointments()
                    } label: {
                        HStack {
                            Text("Zakończone")
                                .fontWeight(.semibold)
                        }
                        .foregroundColor(viewModel.selectedStatus == .done ? .black.opacity(0.9) : .white)
                        .padding()
                    }
                    .background(viewModel.selectedStatus == .done ? Color.ui.vanilla : Color.ui.cultured.opacity(0.9))
                    .cornerRadius(40)
                    
                    Button {
                        viewModel.selectedStatus = .cancelledCustomer
                        viewModel.filterAppointments()
                    } label: {
                        HStack {
                            Text("Odwołane")
                                .fontWeight(.semibold)
                        }
                        .foregroundColor((viewModel.selectedStatus == .cancelledEmployee || viewModel.selectedStatus == .cancelledCustomer) ? .black.opacity(0.9) : .white)
                        .padding()
                    }
                    .background((viewModel.selectedStatus == .cancelledEmployee || viewModel.selectedStatus == .cancelledCustomer) ? Color.ui.vanilla : Color.ui.cultured.opacity(0.9))
                    .cornerRadius(40)
                }
                .padding(.bottom)
                
                
                if userRole == .client {
                    VStack(spacing: 15) {
                        ForEach(viewModel.filteredAppointments, id: \.id) { appointment in
                            AppointmentRowView(appointment: appointment, viewModel: viewModel)
                        }
                    }
                    .padding()
                }
                
                else if userRole == .employee {
                    VStack(spacing: 20) {
                        ForEach(Array(viewModel.sortedDates.enumerated()), id: \.element) { index, date in
                            if let appointmentsForDate = viewModel.groupedAppointments[date] {
                                AppointmentsDropdownView(
                                    appointments: appointmentsForDate,
                                    date: date,
                                    appointmentsCount: appointmentsForDate.count,
                                    isInitiallyExpanded: false
                                )
                            }
                        }
                    }
                }
                
              
            }
            
            .navigationTitle("Twoje wizyty")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        viewModel.resetState()
                        viewModel.onAppear(customerId: clientID ?? 0)
                    }) {
                        Image(systemName: "arrow.clockwise")
                            .font(.system(size: 16, weight: .bold))
                    }
                }
            }
        }
        
        .onAppear {
            viewModel.onAppear(customerId: clientID ?? 0)
        }
        .onChange(of: viewModel.areAllDataFetched) {
            if viewModel.areAllDataFetched {
                viewModel.getAppointments()
            }
        }
        .overlay(
            Group {
                if !viewModel.areAllDataFetched {
                    ProgressView("Ładowanie...")
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(.black)
                }
            }
        )
        
    }

}

#Preview {
    AppointmentsHistoryView()
}
