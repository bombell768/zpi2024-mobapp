//
//  RateRowView.swift
//  Umow.sie
//
//  Created by Bartosz Strzecha on 29/11/2024.
//

import SwiftUI

struct RateRowView: View {
    
    var clientName: String
    var rate: Double
    var servicesNames: [String]
    var employeeName: String
    var description: String
    
    var body: some View {
        
        VStack(alignment: .leading) {
            HStack(spacing: 60) {
                Text("\(clientName)")
                    .font(.title2)
  
                Spacer()
            }
            
            HStack(alignment: .center) {
                Image(systemName: "checklist")
                    .resizable()
                    .frame(width: 18, height: 18)
      
                VStack(alignment: .leading) {
                    ForEach(servicesNames, id: \.self) { serviceName in
                        Text(serviceName)
                            .font(.body)
                    }
                }
                .padding(.horizontal, 4)
                
                Spacer()
                
                Image(systemName: "person.fill")
                    .resizable()
                    .frame(width: 18, height: 18)
 
                
                Text("\(employeeName)")

            }
            .padding(.trailing, 40)
            
            HStack {
                Image(systemName: "star.fill")
                    .resizable()
                    .frame(width: 18, height: 18)
                    .foregroundColor(.yellow)
                
                Text(String(format: "%.2f", rate))
                    .padding(.top, 1)
                    .fontWeight(.semibold)
            }
            
            Text(description)
                .font(.body)
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.ui.vanilla, lineWidth: 1)
                )
            
            
        }
        .frame(maxWidth: .infinity)
        .padding()
        .padding(.leading, 10)
        .background(Color.ui.cultured)
        .cornerRadius(20)
        
    }
}

#Preview {
    RateRowView(clientName: "Danuśka", rate: 5.0, servicesNames: ["strzyżenie damskie", "koloryzacja", "modelowanie"], employeeName: "Karolina", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas tempor elit quis leo eleifend pulvinar. Vivamus consectetur convallis congue.")
}
