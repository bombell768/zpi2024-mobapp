//
//  ChangeDateView.swift
//  Umow.sie
//
//  Created by Bartosz Strzecha on 05/12/2024.
//

import SwiftUI

struct ChangeDateView: View {
    
    var title: String
    var appointment: Appointment
    @State var viewModel = AppointmentBookingViewModel()
    
    @AppStorage("userID") private var userID: Int?
    
    var body: some View {
        NavigationStack {
            ScrollView {
                
                VStack (alignment: .leading, spacing: 14) {
                    
                    
                    Text("Wybierz nowy termin")
                        .font(.title2)
                        .bold()
                    
                    if !viewModel.dates.isEmpty {
                        DatePicker("Data wizyty", selection: $viewModel.dateSelection, in: viewModel.dateRange, displayedComponents: .date)
                            .datePickerStyle(.graphical)
                            .tint(.yellow)
                    } else {
                        DatePicker("Data wizyty", selection: $viewModel.dateSelection, in: viewModel.dateRange, displayedComponents: .date)
                            .datePickerStyle(.graphical)
                            .tint(.yellow)
                        
                    }
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(viewModel.employeeTimeSlots.filter { timeSlot in
                                Calendar.current.isDate(timeSlot.date, inSameDayAs: viewModel.dateSelection)
                            }, id: \.self) { timeSlot in
                                ChoiceView(text: timeSlot.time.formattedToMinutes(), isSelected: timeSlot == viewModel.selectedTimeSlot)
                                    .onTapGesture {
                                        viewModel.selectedTimeSlot = timeSlot
                                    }
                            }
                        }
                    }
                    
                    Text("O wizycie")
                        .font(.title2)
                        .bold()
                        .padding(.top, 20)
                    
                    HStack(alignment: .center) {
                        VStack(alignment: .leading, spacing: 6) {
                            ForEach(appointment.services.map { $0.name }, id: \.self) {serviceName in
                                Text(serviceName)
                                    .font(.title2)
                            }
                            
                            HStack(spacing: 10) {
                                Image(systemName: "person.fill")
                                Text("\(appointment.employee.name)")
                            }
                            
                            HStack(alignment: .top, spacing: 10) {
                                Image(systemName: "mappin.and.ellipse")
                                
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
                            
                            HStack(spacing: 10) {
                                Image(systemName: "polishzlotysign.circle")
                                Text(appointment.totalPrice())
                            }
                            
                            HStack(spacing: 10) {
                                Image(systemName: "hourglass.circle")
                                Text(appointment.totalDurationFormatted())
                            }
                            
                            if (viewModel.selectedTimeSlot.time.hour != 0) {
                                HStack(spacing: 10) {
                                    Image(systemName: "calendar")
                                    Text("\(viewModel.dateSelection.formatted(date: .complete, time: .omitted))")
                                }
                                
                                HStack(spacing: 10) {
                                    Image(systemName: "clock")
                                    Text("\(viewModel.selectedTimeSlot.time.formattedToMinutes()) - \(self.getEndTime())")
                                }
                            }
                        }
                        
                        Spacer()
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .padding(.leading, 6)
                    .background(Color.ui.cultured)
                    .cornerRadius(20)
                    
                    VStack {
                        Button {
                            viewModel.rescheduleAppointment(appointmentId: appointment.id, userId: userID ?? 0, userRole: "C", newDate: viewModel.dateSelection, newTime: viewModel.selectedTimeSlot.time)
                        } label: {
                            HStack {
                                Text("Umów")
                                    .fontWeight(.bold)
                            }
                            .foregroundColor(.black)
                            .frame(width: 150, height: 48)
                            
                        }
                        .background(Color.ui.vanilla)
                        .cornerRadius(10)
                        .padding(.top, 10)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 20)
                    
                }
                .padding()
            }
            .navigationTitle(title)
            .navigationDestination(isPresented: $viewModel.backFromAppointmentRescheduling) {
                AppointmentsHistoryView()
                    .navigationBarBackButtonHidden(true)
            }
            .onAppear {
                viewModel.getAvailabilityDates(salonId: appointment.salon.id, employeeId: appointment.employee.id)
                viewModel.getOpeningHours(salonId: appointment.salon.id)
                viewModel.getTimeSlots(employeeId: appointment.employee.id)
            }
            .onChange(of: viewModel.isLoadingDates) {
                if !viewModel.isLoadingOpeningHours && !viewModel.isLoadingDates && !viewModel.isLoadingTimeSlots {
                    viewModel.generateTimeSlots(for: appointment.employee, selectedServices: appointment.services)
                }
                
            }
            .alert(isPresented: $viewModel.isAppointmentRescheduled) {
                Alert(
                    title: Text("Wizyta umówiona"),
                    message: Text("Twoja wizyta została pomyślnie umówiona w nowym terminie. Sprawdź szczegóły w zakładce \"Wizyty\""),
                    dismissButton: .default(Text("OK"), action: {
                        viewModel.backFromAppointmentRescheduling = true
                    })
                )
            }
        }
    }
    
    private func getEndTime() -> String {
        let totalMinutes = appointment.services.reduce(0) { $0 + $1.duration } * 15
        
        let endTime = viewModel.selectedTimeSlot.time.adding(minutes: totalMinutes)
        return endTime.formattedToMinutes()
    }
}

#Preview {
    ChangeDateView(title: "Zmiana daty",
                   appointment:
                    Appointment(
                        id: 19,
                        date: Date(),
                        time: Time(hour: 12, minute: 45, second: 0),
                        status: .done,
                        salon: Salon(id: 1, name: "Atelier Paris", phoneNumber: "654-231-908", city: "Wrocław", street: "ul. Pl. Grunwaldzki", buildingNumber: "9", postalCode: "00-076"),
                        employee: Employee(),
                        client: Client(),
                        services: [],
                        isRated: true))
}
