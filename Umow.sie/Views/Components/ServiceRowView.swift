//
//  ServiceRowView.swift
//  Umow.sie
//
//  Created by Bartosz Strzecha on 05/11/2024.
//

import SwiftUI

struct ServiceRowView: View {
    var salon: Salon
    var service: Service
    var viewModel: SalonDetailViewModel
    
    var isSelected: Bool {
        viewModel.isServiceSelected(service)
    }
    
    var body: some View {
        HStack(alignment: .center) {
            VStack(alignment: .leading) {
                Text(service.name)
                    .font(.title2)
                Text(service.description)
                    .font(.caption)
                Text("\(service.duration * 15) min")
            }
            
            Spacer()
            
            let formattedValue = String(format: "%.f", service.price)
            Text("\(formattedValue) zł")
                .font(.headline)
                .padding(.trailing, 5)
            
            Button(action: {
                viewModel.toggleServiceSelection(service)
            }) {
                HStack {
                    Text(isSelected ? "Odznacz" : "Wybierz")
                        .fontWeight(.bold)
                }
                .foregroundColor(.black.opacity(0.9))
                .frame(width: 100, height: 48)
            }
            .background(isSelected ? Color.red.opacity(0.9) : Color.ui.vanilla)
            .cornerRadius(10)
            .disabled(!isSelected && viewModel.selectedServices.count >= 3)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color.ui.cultured)
        .cornerRadius(20)
    }
}


#Preview {
    ServiceRowView(
        salon: Salon(),
        service: Service(id: 1, name: "Cięcie", duration: 2, price: 70, description: "Zwykłe cięcie"),
        viewModel: SalonDetailViewModel())
}
