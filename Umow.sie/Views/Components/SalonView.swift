//
//  SalonView.swift
//  Umow.sie
//
//  Created by Bartosz Strzecha on 24/10/2024.
//

import SwiftUI

struct SalonView: View {
    var name: String
    var address: String
    var city: String
    
    var body: some View {
        HStack(alignment: .center) {
            VStack(alignment: .leading) {
                Text(name)
                    .font(.title2)
                Text(address)
                    .font(.caption)
                Text(city)
                    .font(.caption)
            }
            
            Spacer()
            
            Button {
                
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
    SalonView(name: "Atelier Paris", address: "ul. Kościuszki 1", city: "Wrocław")
}
