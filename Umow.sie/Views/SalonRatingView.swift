//
//  SalonRatingView.swift
//  Umow.sie
//
//  Created by Bartosz Strzecha on 29/11/2024.
//

import SwiftUI

struct SalonRatingView: View {
    
    var salonName: String
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 12) {
                    Text("Oceny")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    
                    Text(salonName)
                        .font(.title)
                        .fontWeight(.semibold)
                    
                    VStack(spacing: 15) {
                        RateRowView(clientName: "Kasia", rate: 5.0, servicesNames: ["strzyżenie damskie", "koloryzacja", "modelowanie"], employeeName: "Karolina", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas tempor elit quis leo eleifend pulvinar. Vivamus consectetur convallis congue.")
                        RateRowView(clientName: "Patrycja", rate: 5.0, servicesNames: ["strzyżenie damskie"], employeeName: "Karolina", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas tempor elit quis leo eleifend pulvinar. Vivamus consectetur convallis congue.")
                        RateRowView(clientName: "Adam", rate: 5.0, servicesNames: ["strzyżenie damskie", "koloryzacja", "modelowanie"], employeeName: "Karolina", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas tempor elit quis leo eleifend pulvinar. Vivamus consectetur convallis congue.")
                        RateRowView(clientName: "Adam", rate: 5.0, servicesNames: ["strzyżenie damskie", "koloryzacja", "modelowanie"], employeeName: "Karolina", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas tempor elit quis leo eleifend pulvinar. Vivamus consectetur convallis congue.")
                        RateRowView(clientName: "Danuśka", rate: 5.0, servicesNames: ["strzyżenie damskie", "koloryzacja", "modelowanie"], employeeName: "Karolina", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas tempor elit quis leo eleifend pulvinar. Vivamus consectetur convallis congue.")
                        
                    }
                }
                .padding()
            }
            
          
        }
    }
}

#Preview {
    SalonRatingView(salonName: "Salon ABCD")
}
