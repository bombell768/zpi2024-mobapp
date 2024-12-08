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
                            ServiceRowView(salon: salon, service: service, viewModel: viewModel)
                        }
                    }
                    
                }
                .padding(.horizontal)
            }
        }
    //    .toolbarBackground(.hidden, for: .navigationBar)
        .onAppear {
            viewModel.fetchServicesAndCategories(salonId: salon.id)
//            viewModel.selectedServices.removeAll()
        }
        
        if(!viewModel.selectedServices.isEmpty) {
            VStack(alignment: .leading, spacing: 14) {
                HStack(alignment: .top) {
                    VStack(alignment: .leading) {
                        Text("Wybrane usługi:")
                            .font(.headline)
                        
                        
                        ForEach(viewModel.selectedServices) { service in
                            Text("\(service.name)")
                                .font(.body)
                        }
                    }
                   
                    
                    Spacer()
                    

                    Button(action: {
                        viewModel.selectedServices.removeAll()
                    }) {
                        Text("Wyczyść")
                            .foregroundColor(Color.ui.vanilla)
                            .fontWeight(.bold)

                            .cornerRadius(10)
                    }

                }
                
                HStack {
                    Text("Razem: \(String(format: "%.f", viewModel.getTotalPrice())) zł")
                        .font(.headline)
                    
                    Spacer()
                    
                    Text("Całkowity czas: \(viewModel.getTotalDuration())")
                        .font(.headline)
                }
      
                
                
                NavigationLink {
                    AppointmentBookingView(salon: salon, servicesIndices: viewModel.getServicesIndices(), services: viewModel.selectedServices, viewModel: AppointmentBookingViewModel())
                } label: {
                    Text("Wybierz termin")
                        .foregroundColor(.black.opacity(0.9))
                        .fontWeight(.bold)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(viewModel.selectedServices.isEmpty ? Color.gray : Color.ui.vanilla)
                        .cornerRadius(10)
                }
                .disabled(viewModel.selectedServices.isEmpty)
            }
            .padding()
            .background(Color(UIColor.systemBackground).shadow(radius: 5))
        }
        
    }
        
}


#Preview {
    SalonDetailView(salon: Salon(id: 1, name: "Salon 1", phoneNumber: "22222", city: "warszawa", street: "Kasprowicza", buildingNumber: "1", postalCode: "22222"))
}
