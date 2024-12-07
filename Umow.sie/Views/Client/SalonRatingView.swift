//
//  SalonRatingView.swift
//  Umow.sie
//
//  Created by Bartosz Strzecha on 29/11/2024.
//

import SwiftUI

struct SalonRatingView: View {
    
    @State var salon: Salon
    @State var viewModel = SalonRatingViewModel()
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 12) {
                    Text("Oceny")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    
                    Text(salon.name)
                        .font(.title)
                        .fontWeight(.semibold)
                    
//                    VStack(spacing: 15) {
//                        RateRowView(clientName: "Kasia", rate: 5.0, servicesNames: ["strzyżenie damskie", "koloryzacja", "modelowanie"], employeeName: "Karolina", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas tempor elit quis leo eleifend pulvinar. Vivamus consectetur convallis congue.")
//                        RateRowView(clientName: "Patrycja", rate: 5.0, servicesNames: ["strzyżenie damskie"], employeeName: "Karolina", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas tempor elit quis leo eleifend pulvinar. Vivamus consectetur convallis congue.")
//                        RateRowView(clientName: "Adam", rate: 5.0, servicesNames: ["strzyżenie damskie", "koloryzacja", "modelowanie"], employeeName: "Karolina", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas tempor elit quis leo eleifend pulvinar. Vivamus consectetur convallis congue.")
//                        RateRowView(clientName: "Adam", rate: 5.0, servicesNames: ["strzyżenie damskie", "koloryzacja", "modelowanie"], employeeName: "Karolina", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas tempor elit quis leo eleifend pulvinar. Vivamus consectetur convallis congue.")
//                        RateRowView(clientName: "Danuśka", rate: 5.0, servicesNames: ["strzyżenie damskie", "koloryzacja", "modelowanie"], employeeName: "Karolina", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas tempor elit quis leo eleifend pulvinar. Vivamus consectetur convallis congue.")
//                        
//                    }
                    
                    VStack(spacing: 15) {
                        ForEach(viewModel.ratings) { rating in
                            RateRowView(clientName: rating.client.name,
                                        rate: rating.rating,
                                        servicesNames: rating.services.map { $0.name },
                                        employeeName: rating.employee.name,
                                        description: rating.description)
                        }
                    }
                }
                .padding()
            }
            
          
        }
        .onAppear {
            viewModel.fetchRatingsForSalon(salonID: salon.id)
            viewModel.getServicesForRatings(salonId: salon.id)
        }
        .onChange(of: viewModel.areAllDataFetched) {
            viewModel.getRatings()
            
        }
        .overlay(
            Group {
                if !viewModel.areAllDataFetched {
                    ProgressView("Loading...")
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(.black)
                }
            }
        )

    }
}

#Preview {
    SalonRatingView(salon: Salon(id: 1, name: "Atelier Paris", phoneNumber: "654-231-908", city: "Wrocław", street: "ul. Pl. Grunwaldzki", buildingNumber: "9", postalCode: "00-076"))
}
