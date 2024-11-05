//
//  ServiceRowView.swift
//  Umow.sie
//
//  Created by Bartosz Strzecha on 05/11/2024.
//

import SwiftUI

struct ServiceRowView: View {
    @State var service: Service
    
    var body: some View {
        HStack(alignment: .center) {
            VStack(alignment: .leading) {
                Text(service.name)
                    .font(.title2)
                Text(service.description)
                    .font(.caption)

            }
            
            Spacer()
            
            let formattedValue = String(format: "%.f", service.price)
            Text("\(formattedValue) zł")
                .font(.headline)
                .padding(.trailing, 5)
            
            
            Button {
                
            } label: {
                HStack {
                    Text("Wybierz")
                        .fontWeight(.bold)
                }
                .foregroundColor(Color(hex: 0x0DADADA))
                .frame(width: 100, height: 48)
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
    ServiceRowView(service: Service(ID: 0, name: "Strzyżenie męskie", description: "Podstawowe strzyżenie męskie", duration: 3 * 15, price:90, category: 1))
}
