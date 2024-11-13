//
//  SalonDetailView.swift
//  Umow.sie
//
//  Created by Bartosz Strzecha on 05/11/2024.
//

import SwiftUI

struct SalonDetailView: View {
    @State var salon: Salon

    
    var body: some View {
        ScrollView {
            Image("toolbarlogo")
                .resizable()
                .scaledToFit()
                .frame(width: 300)
                .cornerRadius(5)
            
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
                    Text("Męskie")
                        .font(.title3)
                        .bold()
                        .padding(.top)
                    
                    ServiceRowView(service: Service(ID: 0, name: "Strzyżenie męskie", description: "Podstawowe strzyżenie męskie", duration: 3 * 15, price:90, category: 1))
                    
                    ServiceRowView(service: Service(ID: 0, name: "Strzyżenie męskie", description: "Podstawowe strzyżenie męskie", duration: 3 * 15, price:90, category: 1))
                    
                    Text("Manicure")
                        .font(.title3)
                        .bold()
                        .padding(.top)
                    
                    ServiceRowView(service: Service(ID: 0, name: "Strzyżenie męskie", description: "Podstawowe strzyżenie męskie", duration: 3 * 15, price:90, category: 1))
                    
                    ServiceRowView(service: Service(ID: 0, name: "Strzyżenie męskie", description: "Podstawowe strzyżenie męskie", duration: 3 * 15, price:90, category: 1))
                    
                    ServiceRowView(service: Service(ID: 0, name: "Strzyżenie męskie", description: "Podstawowe strzyżenie męskie", duration: 3 * 15, price:90, category: 1))
                    
                }
                .padding(.horizontal)
 
                
            }
        }
        .toolbarBackground(.hidden, for: .navigationBar)
        .toolbar {
            ToolbarItemGroup(placement: .bottomBar) {
                HStack {
                    VStack {
                        Button {
                            // action
                        } label: {
                            Image(systemName: "house")
                                .foregroundColor(.white)
                        }
                        Text("Strona główna")
                            .font(.system(size: 12))
                            .frame(maxWidth: .infinity)
                    }
                    
                    Spacer()
                    
                    VStack {
                        Button {
                            // action
                        } label: {
                            Image(systemName: "calendar")
                                .foregroundColor(.white)
                        }
                        Text("Wizyty")
                            .font(.system(size: 12))
                            .frame(maxWidth: .infinity)
                    }
                    
                    Spacer()
                    
                    VStack {
                        Button {
                            // action
                        } label: {
                            Image(systemName: "person")
                                .foregroundColor(.white)
                        }
                        
                        Text("Profil")
                            .font(.system(size: 12))
                            .frame(maxWidth: .infinity)
                    }
                }
                .padding(.top, 10)
                
            }
        }
        .toolbarBackground(.black, for: .bottomBar)
        .toolbarBackground(.visible, for: .bottomBar)
    }
}

#Preview {
    SalonDetailView(salon: Salon(id: 0, name: "Atelier Test", phoneNumber: "654-231-908", city: "Wrocław", street: "ul. Pl. Grunwaldzki", buildingNumber: "9", postalCode: "00-076"))
}
