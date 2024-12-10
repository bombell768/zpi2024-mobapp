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
                
                VStack(alignment: .leading, spacing: 12) {
                    VStack(alignment: .leading, spacing: 5) {
                        
                        
                        VStack (alignment: .leading) {
                            Text("Godziny otwarcia")
                                .font(.system(.headline, design: .rounded))
                            
                            if viewModel.areAllOpeningHoursSame() {
                               if let sameHours = viewModel.openingHours.first {
                                   Text("Poniedziałek - Piątek: \(sameHours.formattedHours())")
                                       .font(.system(.body, design: .rounded))
                               }
                            } else {
                               ForEach(viewModel.openingHours, id: \.id) { hours in
                                   Text("\(hours.dayName()): \(hours.formattedHours())")
                                       .font(.system(.body, design: .rounded))
                               }
                            }
                        }
                    }
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                    
                    VStack(alignment: .leading) {
                        Text("Numer telefonu")
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
                    if !viewModel.isServicesFetched {
                        ProgressView("Ładowanie...")
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .background(.black)
                    }
                    if viewModel.serviceCategories.isEmpty && viewModel.isServicesFetched {
                        Text("Salon nie dodał jeszcze żadnych usług.")
                            .foregroundStyle(.red)
                    }
                    else {
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
                    
                }
                .padding(.horizontal)
            }
        }
    //    .toolbarBackground(.hidden, for: .navigationBar)
        .onAppear {
            viewModel.fetchServicesAndCategories(salonId: salon.id)
            viewModel.getOpeningHours(salonId: salon.id)
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
