//
//  AppointmentBookingView.swift
//  Umow.sie
//
//  Created by Bartosz Strzecha on 10/11/2024.
//

import SwiftUI

struct AppointmentBookingView: View {
    @State var employeeSelection: String = "Kasia"
    @State var dateSelection: Date = Date()
    @State var selectedTimeSlot: String = "9:15"
    
    let dateRange: ClosedRange<Date> = {
        let calendar = Calendar.current
        let startComponents = DateComponents(year: 2024, month: 11, day: 4)
        let endComponents = DateComponents(year: 2024, month: 11, day: 17, hour: 23, minute: 59, second: 59)
        return calendar.date(from:startComponents)!
            ...
            calendar.date(from:endComponents)!
    }()

    
    let employees: [String] = ["Kasia", "Jan", "Anastazja", "Patryk"]
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
                            ForEach(employees, id: \.self) { employee in
                                ChoiceView(text: employee, isSelected: employee == employeeSelection)
                                    .onTapGesture {
                                        employeeSelection = employee
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
                    
                    DatePicker("Data wizyty", selection: $dateSelection, in: dateRange, displayedComponents: .date)
                        .datePickerStyle(.graphical)
                        .tint(.yellow)
                }
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(timeSlots, id: \.self) { timeSlot in
                            ChoiceView(text: timeSlot, isSelected: timeSlot == selectedTimeSlot)
                                .onTapGesture {
                                    selectedTimeSlot = timeSlot
                                }
                        }
                    }
                }

                
                VStack(alignment: .leading) {
                    Text("Podsumowanie")
                        .font(.title2)
                        .bold()
                    
                    Text("Strzyżenie męskie")
                    
                    Text("Pracownik: \(employeeSelection)")
                    
                    Text("\(dateSelection.formatted(date: .complete, time: .omitted))  \(selectedTimeSlot) - \(selectedTimeSlot)")
                     
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
    }
}

#Preview {
    AppointmentBookingView()
}
