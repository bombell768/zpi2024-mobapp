//
//  HomeImageView.swift
//  Umow.sie
//
//  Created by Bartosz Strzecha on 25/10/2024.
//

import SwiftUI

struct AppointmentsDropdownView: View {
    let appointments: [Appointment]
    var date: Date
    var appointmentsCount: Int
    var isInitiallyExpanded: Bool
    
    @State private var showList = false
    
    init(appointments: [Appointment], date: Date, appointmentsCount: Int, isInitiallyExpanded: Bool = false) {
        self.appointments = appointments
        self.date = date
        self.appointmentsCount = appointmentsCount
        self.isInitiallyExpanded = isInitiallyExpanded
        _showList = State(initialValue: isInitiallyExpanded)
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            // Nagłówek z datą i liczbą wizyt
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    HStack {
                        Image(systemName: "calendar")
                            .frame(width: 30)
                        Text(date.formatted(date: .long, time: .omitted))
                            .font(.title2)
                    }
                    HStack {    
                        NavigationLink(
                            destination:
                                MapView(location: appointments[0].salon.getAddress())
                                .toolbarBackground(.hidden, for: .navigationBar)
                                .edgesIgnoringSafeArea(.all)
                        ) {
                            Image(systemName: "map")
                                .frame(width: 30)
                            Text("\(appointments[0].salon.name)")
                                .font(.callout)
                        }
                        
                    }
                }

                
                
                
                Spacer()
                
                Text("\(appointmentsCount) wizyty")
                    .font(.headline)
                
                Image(systemName: "chevron.forward")
                    .font(.system(size: 15))
                    .foregroundStyle(.black)
                    .rotationEffect(.degrees(showList ? 90 : 0))
            }
            .bold()
            .foregroundStyle(.black)
            .padding()
            .frame(maxWidth: .infinity)
            .background(
                RoundedRectangle(cornerRadius: 15)
                    .fill(
                        LinearGradient(
                            gradient: Gradient(colors: [Color.ui.vanilla, Color.red.opacity(0.9)]),
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
            )
            .onTapGesture {
                withAnimation {
                    showList.toggle()
                }
            }
            
            if showList {
                VStack(alignment: .leading, spacing: 10) {
                    ForEach(appointments.indices, id: \.self) { index in
                        AppointmentRowView(
                            appointment: appointments[index],
                            viewModel: AppointmentsHistoryViewModel()
                        )
                    }
                }
                
                .transition(.opacity)
            }
        }
        .animation(.easeInOut, value: showList)
        .padding(.horizontal, 10)
    }
}


#Preview {
    AppointmentsDropdownView(appointments: [
        Appointment(
            id: 1,
            date: Date(),
            time: Time(hour: 12, minute: 45, second: 0),
            status: .reserved,
            salon: Salon(id: 1, name: "Atelier Paris", phoneNumber: "654-231-908", city: "Wrocław", street: "ul. Pl. Grunwaldzki", buildingNumber: "9", postalCode: "00-076"),
            employee: Employee(),
            client: Client(),
            services: [],
            isRated: true),
        
        Appointment(
            id: 2,
            date: Date(),
            time: Time(hour: 12, minute: 45, second: 0),
            status: .reserved,
            salon: Salon(id: 1, name: "Atelier Paris", phoneNumber: "654-231-908", city: "Wrocław", street: "ul. Pl. Grunwaldzki", buildingNumber: "9", postalCode: "00-076"),
            employee: Employee(),
            client: Client(),
            services: [],
            isRated: true)],
                             date: Date(),
                             appointmentsCount: 2
    )
}
