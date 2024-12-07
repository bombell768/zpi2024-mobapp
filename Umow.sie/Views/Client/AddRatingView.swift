//
//  AddRatingView.swift
//  Umow.sie
//
//  Created by Bartosz Strzecha on 22/11/2024.
//

import SwiftUI

struct AddRatingView: View {
    
    @Environment(\.dismiss) var dismiss
    
    var appointment: Appointment
    
    @State private var rating = 3.0
    @State private var review: String = ""
    
    var viewModel: AppointmentsHistoryViewModel
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack(alignment: .center) {
                    
                    VStack(alignment: .leading, spacing: 6) {
                        ForEach(appointment.services.map{ $0.name }, id: \.self) {serviceName in
                            Text(serviceName)
                                .font(.title2)
                        }
                        
                        HStack(spacing: 10) {
                            Image(systemName: "person.fill")
                            Text("\(appointment.employee.name)")
                        }
                        
                        HStack(alignment: .top, spacing: 10) {
                            Image(systemName: "mappin.and.ellipse")
                            Text("\(appointment.salon.name)")
                        }
                         
                        HStack(spacing: 10) {
                            Image(systemName: "calendar")
                            Text("\(appointment.date.formatted(date: .complete, time: .omitted))")
                        }
                        
                        HStack(spacing: 10) {
                            Image(systemName: "clock")
                            Text(appointment.time.formattedToMinutes())
                        }
                    }
                    Spacer()
                }
                
                
                Divider()
                    .padding()
                
                VStack(alignment: .leading, spacing: 40) {
                    VStack(alignment: .leading, spacing: 22) {
                        Text("Twoja ocena")
                            .font(.system(.title3))
                        
                        HStack(alignment: .center, spacing: 24) {
                            StarRatingView(rating: $rating)
                            
                            Text(String(format: "%.1f", rating) + " / 5.0")
                                .font(.system(size: 18))
                        }
                        
                    }
                    
                    
                
                    VStack(alignment: .leading) {
                        Text("Podziel się z nami swoją opnią")
                            .font(.system(.title3))
                        
                        FormTextView(value: $review, height: 200)
                    }
                    
                    
                }
                
                
                

                
                Spacer()
                
                
                
            }
            .padding()
            
            .navigationBarTitle("Oceń wizytę")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                    }
                    
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    
                    Button {
                        viewModel.addRating(rating: rating, description: review, employeeId: appointment.employee.id, appointmentId: appointment.id)
                        viewModel.filterAppointments()
                        dismiss()
                    } label: {
                        Text("Dodaj ocenę")
                            .font(.headline)
                            .foregroundColor(.yellow)
                    }
                    
                }
            }
            
        }
        .tint(.yellow)
    }
}

#Preview {
    AddRatingView(appointment:
                    Appointment(
                        id: 1,
                        date: Date(),
                        time: Time(hour: 12, minute: 45, second: 0),
                        status: .done,
                        salon: Salon(id: 1, name: "Atelier Paris", phoneNumber: "654-231-908", city: "Wrocław", street: "ul. Pl. Grunwaldzki", buildingNumber: "9", postalCode: "00-076"),
                        employee: Employee(),
                        services: [],
                        isRated: false),
                  viewModel: AppointmentsHistoryViewModel())

}
