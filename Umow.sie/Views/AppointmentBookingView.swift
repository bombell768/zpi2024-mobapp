//
//  AppointmentBookingView.swift
//  Umow.sie
//
//  Created by Bartosz Strzecha on 10/11/2024.
//

import SwiftUI

struct AppointmentBookingView: View {
    
    var salon: Salon
    var service: Service
    
    @State var viewModel = AppointmentBookingViewModel()
    
 
//    let employees: [String] = ["Kasia", "Jan", "Anastazja", "Patryk"]
    let timeSlots: [String] = ["9:15", "9:30", "9:45", "10:00", "10:15", "10:30", "10:45", "11:00", "11:15", "11:30", "11:45", "12:00", "12:15", "12:30", "12:45", "13:00", "13:15", "13:30", "13:45", "14:00", "14:15", "14:30", "14:45", "15:00", "15:15", "15:30", "15:45", "16:00"]
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 40) {
                VStack (alignment: .leading, spacing: 20){  
                    Text("Wybierz pracownika")
                        .font(.title2)
                        .bold()
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(viewModel.employees, id: \.self) { employee in
                                ChoiceView(text: employee.name, isSelected: employee == viewModel.employeeSelection)
                                    .onTapGesture {
                                        viewModel.employeeSelection = employee
                                        viewModel.getAvailabilityDates(salonId: salon.id, employeeId: employee.id)
                                        viewModel.getOpeningHours(salonId: salon.id)
                                        viewModel.getTimeSlots(employeeId: employee.id)
                                        viewModel.currentEmployee = employee
                                        
                                        
                                    }
                            }
                        }
                    }
                    
//                    Menu {
//                        Picker(selection: $employeeSelection) {
//                            ForEach(employees, id: \.self) { employee in
//                                Text(employee)
//                                    .fontWeight(.bold)
//                                    .tag(employee)
//                            }
//                        } label: {}
//                    } label: {
//                        Text(employeeSelection)
//                            .font(.system(size: 18))
//                            .foregroundStyle(.yellow)
//                            .frame(width: 100, height: 50)
//                            .background(Color.gray.opacity(0.9))
//                            .cornerRadius(10)
//                    }
                    
                    
//                    Picker("Pracownik", selection: $employeeSelection) {
//                        ForEach(employees, id: \.self) { employee in
//                            Text(employee)
//                                .fontWeight(.bold)
//                                .tag(employee)
//                            
//                        }
//                    }
//                    .tint(.yellow)
//                    .frame(width: 100, height: 60)
//                    .background(Color.gray.opacity(0.2))
//                    .cornerRadius(8)
                }
                
                VStack(alignment: .leading) {
                    Text("Wybierz datę")
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

                        
                }
                
                ScrollView(.horizontal, showsIndicators: false) {
//                    HStack {
//                        ForEach(timeSlots, id: \.self) { timeSlot in
//                            ChoiceView(text: timeSlot, isSelected: timeSlot == viewModel.selectedTimeSlot)
//                                .onTapGesture {
//                                    viewModel.selectedTimeSlot = timeSlot
//                                }
//                        }
//                    }
                    
                    HStack {
                        ForEach(viewModel.employeeTimeSlots.filter { timeSlot in
                            Calendar.current.isDate(timeSlot.date, inSameDayAs: viewModel.dateSelection)
                        }, id: \.self) { timeSlot in
                            ChoiceView(text: timeSlot.time.formatted(), isSelected: timeSlot == viewModel.selectedTimeSlot)
                                .onTapGesture {
                                    viewModel.selectedTimeSlot = timeSlot
                                }
                        }
                    }
                }

                
                VStack(alignment: .leading) {
                    Text("Podsumowanie")
                        .font(.title2)
                        .bold()
                    
                    Text("Usługa: \(service.name)")
                    
                    Text("Pracownik: \(viewModel.employeeSelection.name)")
                    
                    Text("\(viewModel.dateSelection.formatted(date: .complete, time: .omitted))  \(viewModel.selectedTimeSlot.time.formatted()) - \(viewModel.selectedTimeSlot.time.formatted())")
                     
                }
                
                VStack{
                    Button {
                        print("Book appointment...")
                    } label: {
                        HStack {
                            Text("Umów")
                                .fontWeight(.bold)
                        }
                        .foregroundColor(.black)
                        .frame(width: 150, height: 48)
                        
                    }
                    .background(.yellow)
                    .cornerRadius(10)
                    .padding(.top, 10)
                }
                .frame(maxWidth: .infinity)

            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
        }
        .onAppear {
            let serviceIds = [service.id]
            viewModel.getEmployees(salonId: salon.id, serviceIds: serviceIds)
            
        }
        .onChange(of: viewModel.isLoadingDates) {
            if !viewModel.isLoadingOpeningHours && !viewModel.isLoadingDates && !viewModel.isLoadingTimeSlots {
                viewModel.generateTimeSlots(for: viewModel.currentEmployee!)
            }
            
        }
    }
}

#Preview {
    AppointmentBookingView(
        salon: Salon(),
        service: Service(id: 1, name: "Koloryzacja", duration: 3, price: 70, description: "Na krótko"))
}
