//
//  AppointmentsHistoryView.swift
//  Umow.sie
//
//  Created by Bartosz Strzecha on 20/11/2024.
//

import SwiftUI

struct AppointmentsHistoryView: View {
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
                    .background(.yellow)
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
                    .background(.gray.opacity(0.9))
                    .cornerRadius(40)
                    
                    Button {
                        
                    } label: {
                        HStack {
                            Text("Umówione")
                                .fontWeight(.semibold)
                        }
                        .foregroundColor(.white)
                        .padding()
                    }
                    .background(.gray.opacity(0.9))
                    .cornerRadius(40)
                }
                .padding(.bottom)
                
                
                VStack (spacing: 15) {
                    AppointmentRowView(serviceName: "Strzyżenie damskie", salonName: "Atelier Paris", salonAddress: "Marszalkowska 34, Warszawa", employeeName: "Ania", date: Date(), time: Time(hour: 12, minute: 45, second: 0))
                    AppointmentRowView(serviceName: "Strzyżenie damskie", salonName: "Atelier Paris", salonAddress: "Marszalkowska 34, Warszawa", employeeName: "Ania", date: Date(), time: Time(hour: 12, minute: 45, second: 0))
                    
                    AppointmentRowView(serviceName: "Strzyżenie damskie", salonName: "Atelier Paris", salonAddress: "Marszalkowska 34, Warszawa", employeeName: "Ania", date: Date(), time: Time(hour: 12, minute: 45, second: 0))
                    
                }
                .padding()
                
                Spacer()
            }

        }
        
        
        
    }
}

#Preview {
    AppointmentsHistoryView()
}
