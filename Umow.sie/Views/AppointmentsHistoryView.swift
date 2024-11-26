//
//  AppointmentsHistoryView.swift
//  Umow.sie
//
//  Created by Bartosz Strzecha on 20/11/2024.
//

import SwiftUI

struct AppointmentsHistoryView: View {
    
    @State var isRatingShown: Bool = false
    
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
                        
                    } label: {
                        HStack {
                            Text("Umówione")
                                .fontWeight(.semibold)
                        }
                        .foregroundColor(.black.opacity(0.9))
                        .padding()
                    }
                    .background(Color.ui.vanilla)
                    .cornerRadius(40)
                    
                    Button {
                        
                    } label: {
                        HStack {
                            Text("Zakończone")
                                .fontWeight(.semibold)
                        }
                        .foregroundColor(.white)
                        .padding()
                    }
                    .background(Color.ui.cultured.opacity(0.9))
                    .cornerRadius(40)
                    
                    Button {
                        
                    } label: {
                        HStack {
                            Text("Odwołane")
                                .fontWeight(.semibold)
                        }
                        .foregroundColor(.white)
                        .padding()
                    }
                    .background(Color.ui.cultured.opacity(0.9))
                    .cornerRadius(40)
                }
                .padding(.bottom)
                
                
                VStack (spacing: 15) {
                    AppointmentRowView(serviceName: "Strzyżenie damskie", salonName: "Atelier Paris", salonAddress: "Marszalkowska 34, Warszawa", employeeName: "Ania", date: Date(), time: Time(hour: 12, minute: 45, second: 0), isRating: $isRatingShown)
                    AppointmentRowView(serviceName: "Strzyżenie damskie", salonName: "Atelier Paris", salonAddress: "Marszalkowska 34, Warszawa", employeeName: "Ania", date: Date(), time: Time(hour: 12, minute: 45, second: 0), isRating: $isRatingShown)
                    
                    AppointmentRowView(serviceName: "Strzyżenie damskie", salonName: "Atelier Paris", salonAddress: "Marszalkowska 34, Warszawa", employeeName: "Ania", date: Date(), time: Time(hour: 12, minute: 45, second: 0), isRating: $isRatingShown)
                    
                }
                .padding()
                
                Spacer()
            }

        }
        .sheet(isPresented: $isRatingShown) {
            AddRatingView(serviceName: "Strzyżenie damskie", salonName: "Atelier Paris", salonAddress: "Marszalkowska 34, Warszawa", employeeName: "Ania", date: Date(), time: Time(hour: 12, minute: 45, second: 0))
        }
        
        
    }
}

#Preview {
    AppointmentsHistoryView()
}
