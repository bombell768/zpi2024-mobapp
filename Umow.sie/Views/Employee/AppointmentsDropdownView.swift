//
//  HomeImageView.swift
//  Umow.sie
//
//  Created by Bartosz Strzecha on 25/10/2024.
//

import SwiftUI

struct DataModel{
    let iconName: String
    var title: String
    var destination: AnyView
}

struct AppointmentsDropdownView: View {
    let listOne: [DataModel] = [
        DataModel(iconName: "text.bubble.fill", title: "Broadcast Lists", destination: AnyView(Text("hehe"))),
        DataModel(iconName: "star.fill", title: "Broadcast Lists View", destination: AnyView(Text("hehe1"))),
        DataModel(iconName: "link", title: "Started Api", destination: AnyView(Text("hehe2"))),
        DataModel(iconName: "key.fill", title: "Started View", destination: AnyView(Text("hehe3")))
    ]
    
    let appointments: [Appointment] = [
        Appointment(
            id: 1,
            date: Date(),
            time: Time(hour: 12, minute: 45, second: 0),
            status: .reserved,
            salon: Salon(id: 1, name: "Atelier Paris", phoneNumber: "654-231-908", city: "Wrocław", street: "ul. Pl. Grunwaldzki", buildingNumber: "9", postalCode: "00-076"),
            employee: Employee(),
            services: [],
            isRated: true),
        Appointment(
            id: 2,
            date: Date(),
            time: Time(hour: 12, minute: 45, second: 0),
            status: .reserved,
            salon: Salon(id: 1, name: "Atelier Paris", phoneNumber: "654-231-908", city: "Wrocław", street: "ul. Pl. Grunwaldzki", buildingNumber: "9", postalCode: "00-076"),
            employee: Employee(),
            services: [],
            isRated: true)]
    
    @State var showList = false
    var body: some View {
        NavigationStack {
            VStack{
                ZStack(alignment: .top){
                    HStack{
                        Image(systemName: "calendar")
                            .frame(width: 30)
                        
                        Text("15 grudnia 2024")
                            .font(.title2)
                        
                        Spacer()
                        
                        Text("13 wizyt")
                            .font(.headline)
                        
                        Image(systemName: "chevron.forward")
                            .font(.system(size: 15))
                            .foregroundStyle((.black.opacity(0.9)))
                            .rotationEffect(.degrees(showList ? 90 : 0))
                    }
                    .bold()
                    .foregroundStyle(.black.opacity(0.9))
                    .padding()
                    .frame(maxWidth: .infinity)
                    .frame(height: showList ? 53 : 53)
                    .background(Color.ui.vanilla, in: RoundedRectangle(cornerRadius: 15))
                    .onTapGesture {
                        withAnimation{
                            showList.toggle()
                        }
                    }
                    .zIndex(1)
                    
                    if showList {
                        ForEach(appointments.indices,id: \.self){ item in
                            HStack{
                                AppointmentRowView(appointment: appointments[item], viewModel: AppointmentsHistoryViewModel())
                            }
                            //                        .opacity(showList ? 1 : 0.5)
                            .offset(y: showList ? CGFloat(item * 290) : CGFloat(item * 20))
                            .scaleEffect(showList ? 1 : (1 - Double(item) * 0.04))
                            .onTapGesture {
                                withAnimation{
                                    showList.toggle()
                                }
                            }
                            .zIndex(CGFloat(item * -1))
                        }
                        .offset(y: showList ? 63 : 0)
                    }
                }
                .padding(.horizontal)
                Spacer()
            }
        }
    }
}

#Preview {
    AppointmentsDropdownView()
}
