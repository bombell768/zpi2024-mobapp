//
//  SalonDetailView.swift
//  Umow.sie
//
//  Created by Bartosz Strzecha on 05/11/2024.
//

import SwiftUI

struct SalonDetailView: View {
    
    var salon: Salon
    @State var viewModel = SalonDetailViewModel()
    
    var body: some View {
        ScrollView {
//            Image("toolbarlogo")
//                .resizable()
//                .scaledToFit()
//                .frame(width: 300)
//                .cornerRadius(5)
            
            VStack(alignment: .leading) {
                NavigationLink(
                    destination:
                        MapView(location: salon.getAddress())
                        .toolbarBackground(.hidden, for: .navigationBar)
                        .edgesIgnoringSafeArea(.all)
                ) {
                    MapView(location: salon.getAddress())
                        .frame(height: 200)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .padding()
                }
                
                Text(salon.name)
                    .font(.title)
                    .bold()
                    .padding(.horizontal)
                    .padding(.bottom)
                
                HStack(alignment: .top) {
                    VStack(alignment: .leading, spacing: 5) {
                        
                        
                        VStack (alignment: .leading) {
                            Text("ADRES")
                                .font(.system(.headline, design: .rounded))
                            
                            Text(salon.street + " " + salon.buildingNumber)
                            Text(salon.postalCode + " " + salon.city)
                        }
                    }
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                    
                    VStack(alignment: .leading) {
                        Text("TELEFON")
                            .font(.system(.headline, design: .rounded))
                        
                        Text(salon.phoneNumber)
                    }
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                    
                }
                .padding(.horizontal)
                
                Text("Usługi")
                    .font(.title2)
                    .bold()
                    .padding(.horizontal)
                    .padding(.top)
                
                VStack(alignment: .leading) {
                    ForEach(viewModel.serviceCategories) { category in
                        Text("\(category.name)")
                            .font(.title3)
                            .bold()
                            .padding(.top)
                        ForEach(category.services) { service in
                            ServiceRowView(salon: salon, service: service)
                        }
                    }
                    
                }
                .padding(.horizontal)
 
                
            }
        }
    //    .toolbarBackground(.hidden, for: .navigationBar)
        
                
                .onAppear {
                    viewModel.fetchServicesAndCategories(salonId: salon.id)
                }
            }
        }


#Preview {
    SalonDetailView(salon: Salon(id: 1, name: "Salon 1", phoneNumber: "22222", city: "warszawa", street: "Kasprowicza", buildingNumber: "1", postalCode: "22222"))
}
