//
//  AppointmentsHistoryView.swift
//  Umow.sie
//
//  Created by Bartosz Strzecha on 20/11/2024.
//

import SwiftUI

struct AppointmentsHistoryView: View {
    
    @State var isRatingShown: Bool = false
    
    @State var viewModel = AppointmentsHistoryViewModel()
    
    var body: some View {
        
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading) {
                    Text("Wizyty")
                        .font(.largeTitle)
                        .fontWeight(.semibold)
                    
                }
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .topLeading)
                .padding()
                
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
                
                
//                VStack (spacing: 15) {
//                    AppointmentRowView(serviceNames: ["Strzyżenie damskie"], salonName: "Atelier Paris", salonAddress: "Marszalkowska 34, Warszawa", employeeName: "Ania", date: Date(), time: Time(hour: 12, minute: 45, second: 0), isRating: $isRatingShown)
//                    AppointmentRowView(serviceNames: ["Strzyżenie damskie"], salonName: "Atelier Paris", salonAddress: "Marszalkowska 34, Warszawa", employeeName: "Ania", date: Date(), time: Time(hour: 12, minute: 45, second: 0), isRating: $isRatingShown)
//
//                    AppointmentRowView(serviceNames: ["Strzyżenie damskie"], salonName: "Atelier Paris", salonAddress: "Marszalkowska 34, Warszawa", employeeName: "Ania", date: Date(), time: Time(hour: 12, minute: 45, second: 0), isRating: $isRatingShown)
//
//                }
//                .padding()
                
                VStack(spacing: 15) {
                    ForEach(viewModel.filteredAppointments) { appointment in
                        AppointmentRowView(
                            serviceNames: appointment.services.map { $0.name },
                            salonName: appointment.salon.name,
                            salonAddress: appointment.salon.getAddress(),
                            employeeName: appointment.employee.name,
                            date: appointment.date,
                            time: appointment.time,
                            isRating: $isRatingShown
                        )
                    }
                }
                .padding()
                
              
            }

        }
        .sheet(isPresented: $isRatingShown) {
            AddRatingView(serviceName: "Strzyżenie damskie", salonName: "Atelier Paris", salonAddress: "Marszalkowska 34, Warszawa", employeeName: "Ania", date: Date(), time: Time(hour: 12, minute: 45, second: 0))
        }
        .onAppear {
            viewModel.fetchSalons()
            viewModel.fetchAppointments(customerId: 1)
            viewModel.getServicesForAppointments(customerId: 1)
        }
        .onChange(of: viewModel.areAllDataFetched) {
            viewModel.getAppointments()
            
        }
        
        
    }
}

#Preview {
    AppointmentsHistoryView()
}