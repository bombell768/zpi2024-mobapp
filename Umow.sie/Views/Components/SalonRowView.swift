//
//  SalonView.swift
//  Umow.sie
//
//  Created by Bartosz Strzecha on 24/10/2024.
//

import SwiftUI

struct SalonRowView: View {
    @State var salon: Salon

    
    var body: some View {
        HStack(alignment: .center) {
            VStack(alignment: .leading) {
                Text(salon.name)
                    .font(.title2)
                Text(salon.street + " " + salon.buildingNumber)
                    .font(.caption)
                Text(salon.city)
                    .font(.caption)
            }
            
            Spacer()
            
            NavigationLink {
                SalonDetailView(salon: salon)
            } label: {
                HStack {
                    Text("Umów wizytę")
                        .fontWeight(.bold)
                }
                .foregroundColor(Color(hex: 0x0DADADA))
                .frame(width: 150, height: 48)
            }
            .background(Color(hex: 0x0B68D40))
            .cornerRadius(10)

        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color.gray)
        .cornerRadius(20)
        
    }
}

#Preview {
    SalonRowView(salon: Salon(id: 0, name: "Atelier Paris", phoneNumber: "654-231-908", city: "Wrocław", street: "ul. Pl. Grunwaldzki", buildingNumber: "9", postalCode: "00-076"))
}
