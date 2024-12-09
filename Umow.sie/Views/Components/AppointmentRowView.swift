//
//  AppointmentRowView.swift
//  Umow.sie
//
//  Created by Bartosz Strzecha on 19/11/2024.
//

import SwiftUI

struct AppointmentRowView: View {
    
    var appointment: Appointment
    @State var viewModel: AppointmentsHistoryViewModel
    
    @State var isRatingShown: Bool = false
    
    @AppStorage("userRole") private var userRole: UserRole?
    
    var body: some View {
        HStack(alignment: .center) {
            VStack(alignment: .leading, spacing: 6) {
                ForEach(appointment.services.map { $0.name }, id: \.self) {serviceName in
                    Text(serviceName)
                        .font(.title2)
                }
                
                if userRole == .client {
                    HStack(spacing: 10) {
                        Image(systemName: "person.fill")
                        Text("\(appointment.employee.name)")
                    }
                    
                    HStack(alignment: .top, spacing: 10) {
                        Image(systemName: "map")
                        
                        NavigationLink(
                            destination:
                                MapView(location: appointment.salon.getAddress())
                                .toolbarBackground(.hidden, for: .navigationBar)
                                .edgesIgnoringSafeArea(.all)
                        ) {
                            VStack(alignment: .leading) {
                                Text("\(appointment.salon.name)")
                                Text("\(appointment.salon.getAddress())")
                            }
                            .foregroundStyle(Color.ui.vanilla)
                        }
                    }
                }
                else if userRole == .employee {
                    HStack(spacing: 10) {
                        Image(systemName: "person.fill")
                        Text("\(appointment.client.name) \(appointment.client.surname)")
                    }
                }
                
                    
                
                
                HStack(spacing: 10) {
                    Image(systemName: "polishzlotysign.circle")
                    Text(appointment.totalPrice())
                }
                
                if userRole == .client {
                    HStack(spacing: 10) {
                        Image(systemName: "hourglass.circle")
                        Text(appointment.totalDurationFormatted())
                    }
                    
                    
                    HStack(spacing: 10) {
                        Image(systemName: "calendar")
                        Text("\(appointment.date.formatted(date: .complete, time: .omitted))")
                    }
                    
                    HStack(spacing: 10) {
                        Image(systemName: "clock")
                        Text("\(appointment.time.formattedToMinutes())")
                    }
                }
                else if userRole == .employee {
                    HStack(spacing: 10) {
                        Image(systemName: "clock")
                        Text("\(appointment.time.formattedToMinutes()) - \(appointment.time.adding(minutes: appointment.totalDuration()).formattedToMinutes())")
                    }
                }
                
                renderButtons(for: appointment.status)
                    .padding(.top)
                    .frame(maxWidth: .infinity)
                
            }
            
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .padding()
        .padding(.leading, 10)
        .background(Color.ui.cultured)
        .cornerRadius(20)
        .sheet(isPresented: $isRatingShown) {
            AddRatingView(appointment: appointment, viewModel: viewModel)
        }
        .alert(isPresented: $viewModel.isCancelWarningVisible) {
            Alert(
                title: Text("Jesteś pewny?"),
                message: Text("Czy na pewno chcesz odwołać wizytę?"),
                primaryButton: .destructive(Text("Tak - Odwołuję wizytę")) {
                    print("appointmentId: \(appointment.id)")
                    viewModel.cancelAppointment(appointmentId: appointment.id)
                },
                secondaryButton: .cancel(Text("Nie")) {
                    viewModel.isCancelWarningVisible = false
                }            )
}
    }
    
    @ViewBuilder
    private func renderButtons(for status: AppointmentStatus) -> some View {
        switch status {
        case .reserved:
            HStack(spacing: 30) {
                NavigationLink {
                    ChangeDateView(title: "Zmień termin", appointment: appointment, context: .reschedule)
                } label: {
                    HStack {
                        Text("Zmień termin")
                            .fontWeight(.bold)
                    }
                    .foregroundColor(.black.opacity(0.9))
                    .frame(width: 150, height: 48)
                .background(Color.ui.vanilla)
                .cornerRadius(10)
                }

                ManageAppointmentButton(title: "Odwołaj") {
                    viewModel.isCancelWarningVisible = true
                }
            }
            
        case .done:
            HStack(spacing: 30) {
                NavigationLink {
                    ChangeDateView(title: "Umów ponownie", appointment: appointment, context: .rebook)
                } label: {
                    HStack {
                        Text("Umów ponownie")
                            .fontWeight(.bold)
                    }
                    .foregroundColor(.black.opacity(0.9))
                    .frame(width: 150, height: 48)
                .background(Color.ui.vanilla)
                .cornerRadius(10)
                }
                
                if !appointment.isRated {
                    ManageAppointmentButton(title: "Oceń") {
                        isRatingShown.toggle()
                    }
                }
                else {
                    Text("Wizyta została oceniona")
                        .fontWeight(.semibold)
                        .frame(width: 150, height: 48)
                        .multilineTextAlignment(.center)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.ui.vanilla, style: StrokeStyle(lineWidth: 2)) 
                        )
                }
                
            }
            
        case .cancelledEmployee, .cancelledCustomer:
            HStack {
                NavigationLink {
                    ChangeDateView(title: "Umów ponownie", appointment: appointment, context: .rebook)
                } label: {
                    HStack {
                        Text("Umów ponownie")
                            .fontWeight(.bold)
                    }
                    .foregroundColor(.black.opacity(0.9))
                    .frame(width: 150, height: 48)
                .background(Color.ui.vanilla)
                .cornerRadius(10)
                }
            }
            
        case .unknown:
            EmptyView() 
        }
    }
}

#Preview {
    AppointmentRowView(appointment: Appointment(
        id: 1,
        date: Date(),
        time: Time(hour: 12, minute: 45, second: 0),
        status: .reserved,
        salon: Salon(id: 1, name: "Atelier Paris", phoneNumber: "654-231-908", city: "Wrocław", street: "ul. Pl. Grunwaldzki", buildingNumber: "9", postalCode: "00-076"),
        employee: Employee(),
        client: Client(),
        services: [],
        isRated: true),
        viewModel: AppointmentsHistoryViewModel())
}


struct ManageAppointmentButton: View {
    let title: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
           HStack {
               Text(title)
                   .fontWeight(.bold)
           }
           .foregroundColor(.black.opacity(0.9))
           .frame(width: 150, height: 48)
       }
       .background(Color.ui.vanilla)
       .cornerRadius(10)
    }
}
