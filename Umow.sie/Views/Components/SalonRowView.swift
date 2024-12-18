//
//  SalonView.swift
//  Umow.sie
//
//  Created by Bartosz Strzecha on 24/10/2024.
//

import SwiftUI

struct SalonRowView: View {
    @Bindable var salon: Salon
    
    var body: some View {
        HStack(alignment: .center) {
            VStack(alignment: .leading) {
                Text(salon.name)
                    .font(.headline)
                    .fontWeight(.semibold)
                
                Text(salon.street + " " + salon.buildingNumber)
                    .font(.caption)
                Text(salon.city)
                    .font(.caption)
            }
            .foregroundStyle(Color.ui.black)

            
            Spacer()
            
            if let rating = salon.averageRating {
                if(rating > 0) {
                    NavigationLink(destination: SalonRatingView(salon: salon)) {
                        HStack(alignment: .center) {
                            Image(systemName: "star.fill")
                                .resizable()
                                .frame(width: 18, height: 18)
                                .foregroundColor(.yellow)
                            Text(String(format: "%.2f", rating))
                                .padding(.top, 1)
                                .fontWeight(.semibold)
                                .foregroundStyle(.white)
                        }
                        .padding(.trailing, 6)
                    }
                }
                else {
                    Text("Brak ocen")
                        .font(.caption)
                        .foregroundColor(.gray)
                        .padding(.trailing, 6)
                }
                
            } else {
                Text("Brak ocen")
                    .font(.caption)
                    .foregroundColor(.gray)
                    .padding(.trailing, 6)

            }

            NavigationLink {
                SalonDetailView(salon: salon)
            } label: {
                HStack {
                    Text("Umów wizytę")
                        .fontWeight(.bold)
                        .foregroundStyle(.black.opacity(0.9))
                }
                .foregroundColor(Color.ui.black)
                .frame(width: 130, height: 48)
            }
            .background(Color.ui.vanilla)
            .cornerRadius(10)
        }
        .frame(maxWidth: .infinity, maxHeight: 60)
        .padding()
        .background(Color.ui.cultured)
        .cornerRadius(20)
        
    }
}

#Preview {
    SalonRowView(salon: Salon(id: 0, name: "Atelier Paris", phoneNumber: "654-231-908", city: "Wrocław", street: "ul. Pl. Grunwaldzki", buildingNumber: "9", postalCode: "00-076"))
}
