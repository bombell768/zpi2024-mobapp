//
//  AppointmentRowView.swift
//  Umow.sie
//
//  Created by Bartosz Strzecha on 19/11/2024.
//

import SwiftUI

struct AppointmentRowView: View {
    
    let serviceNames: [String]
    let salonName: String
    let salonAddress: String
    let employeeName: String
    let date: Date
    let time: Time
    
    @Binding var isRating: Bool
    
    var body: some View {
        HStack(alignment: .center) {
            
            VStack(alignment: .leading, spacing: 6) {
                ForEach(serviceNames, id: \.self) {serviceName in
                    Text(serviceName)
                        .font(.title2)
                }
                
                HStack(spacing: 10) {
                    Image(systemName: "person.fill")
                    Text("\(employeeName)")
                }
                    
                HStack(alignment: .top, spacing: 10) {
                    Image(systemName: "mappin.and.ellipse")
                    
                    NavigationLink(
                        destination:
                            MapView(location: salonAddress)
                            .toolbarBackground(.hidden, for: .navigationBar)
                            .edgesIgnoringSafeArea(.all)
                    ) {
                        VStack(alignment: .leading) {
                            Text("\(salonName)")
                            Text("\(salonAddress)")
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
                
                HStack(spacing: 30) {
                    Button {
                        isRating.toggle()
                    } label: {
                        HStack {
                            Text("Odwołaj")
                                .fontWeight(.bold)
                        }
                        .foregroundColor(.black.opacity(0.9))
                        .frame(width: 150, height: 48)
                    }
                    .background(Color.ui.vanilla)
                    .cornerRadius(10)
                    
                    
                    NavigationLink {
                        
                    } label: {
                        HStack {
                            Text("Zmień")
                                .fontWeight(.bold)
                        }
                        .foregroundColor(.black.opacity(0.9))
                        .frame(width: 150, height: 48)
                    }
                    .background(Color.ui.vanilla)
                    .cornerRadius(10)
                }
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
    }
}

#Preview {
    AppointmentRowView(serviceNames: ["Strzyżenie damskie", "Koloryzacja", "Modelowanie"], salonName: "Atelier Paris", salonAddress: "Marszalkowska 34, Warszawa", employeeName: "Ania", date: Date(), time: Time(hour: 12, minute: 45, second: 0), isRating: .constant(false))
}
