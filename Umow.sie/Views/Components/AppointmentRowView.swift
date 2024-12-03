//
//  AppointmentRowView.swift
//  Umow.sie
//
//  Created by Bartosz Strzecha on 19/11/2024.
//

import SwiftUI

struct AppointmentRowView: View {
    
    let serviceNames: [String]
    let salon: Salon
    let employee: Employee
    let date: Date
    let time: Time
    let status: AppointmentStatus
    let appointmentId: Int
    
    @State var isRatingShown: Bool = false
    
    var body: some View {
        HStack(alignment: .center) {
            VStack(alignment: .leading, spacing: 6) {
                ForEach(serviceNames, id: \.self) {serviceName in
                    Text(serviceName)
                        .font(.title2)
                }
                
                HStack(spacing: 10) {
                    Image(systemName: "person.fill")
                    Text("\(employee.name)")
                }
                    
                HStack(alignment: .top, spacing: 10) {
                    Image(systemName: "mappin.and.ellipse")
                    
                    NavigationLink(
                        destination:
                            MapView(location: salon.getAddress())
                            .toolbarBackground(.hidden, for: .navigationBar)
                            .edgesIgnoringSafeArea(.all)
                    ) {
                        VStack(alignment: .leading) {
                            Text("\(salon.name)")
                            Text("\(salon.getAddress())")
                        }
                        .foregroundStyle(Color.ui.vanilla)
                    }
                    
                    
                }
                
                
                    
                HStack(spacing: 10) {
                    Image(systemName: "calendar")
                    Text("\(date.formatted(date: .complete, time: .omitted))")
                }
                
                HStack(spacing: 10) {
                    Image(systemName: "clock")
                    Text("\(time.formattedToMinutes())")
                }
                
                renderButtons(for: status)
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
            AddRatingView(serviceNames: serviceNames,
                          salon: salon,
                          employee: employee,
                          date: date,
                          time: time,
                          appointmentId: appointmentId)
        }
    }
    
    @ViewBuilder
    private func renderButtons(for status: AppointmentStatus) -> some View {
        switch status {
        case .reserved:
            HStack(spacing: 30) {
                ManageAppointmentButton(title: "Odwołaj") {
                    
                }
                
                NavigationLink {
                    
                } label: {
                    ManageAppointmentButton(title: "Zmień termin") {}
                }
            }
            
        case .done:
            HStack(spacing: 30) {
                ManageAppointmentButton(title: "Umów ponownie") {
                   
                }
                
                ManageAppointmentButton(title: "Oceń") {
                    isRatingShown.toggle()
                }
            }
            
        case .cancelledEmployee, .cancelledCustomer:
            HStack {
                ManageAppointmentButton(title: "Umów ponownie") {
                   
                }
            }
            
        case .unknown:
            EmptyView() 
        }
    }
}

#Preview {
    AppointmentRowView(serviceNames: ["Strzyżenie damskie", "Koloryzacja", "Modelowanie"],
                       salon: Salon(id: 1, name: "Atelier Paris", phoneNumber: "654-231-908", city: "Wrocław", street: "ul. Pl. Grunwaldzki", buildingNumber: "9", postalCode: "00-076"),
                       employee: Employee(),
                       date: Date(),
                       time: Time(hour: 12, minute: 45, second: 0),
                       status: .done,
                       appointmentId: 1)
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
