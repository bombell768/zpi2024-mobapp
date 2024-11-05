//
//  HomeView.swift
//  Umow.sie
//
//  Created by Bartosz Strzecha on 24/10/2024.
//

import SwiftUI

enum HomeImages: String, CaseIterable {
    case homeImage1 = "home_image_1"
    case homeImage2 = "home_image_2"
    case homeImage3 = "home_image_3"
    case homeImage4 = "home_image_4"
}

struct HomeView: View {
    @State var citySelection: String = "Wrocław"
    
    let cities: [String] = ["Wrocław", "Kraków", "Poznań", "Warszawa", "Szczecin", "Gdańsk", "Katowice"]
    
    
    var body: some View {
        NavigationStack {
            
            ScrollView {
                
                Image("toolbarlogo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300)
                    .cornerRadius(5)

                ScrollView (.horizontal) {
                    HStack {
                        ForEach(HomeImages.allCases, id: \.self) { image in
                            Image(image.rawValue)
                                .resizable()
                                .scaledToFit()
//                                .frame(width: 300, height: 200)
                                .cornerRadius(10)
                                .containerRelativeFrame(.horizontal, count: 1, spacing: 1)
                                .scrollTransition { content, phase in
                                    content
                                        .opacity(phase.isIdentity ? 1.0 : 0.5)
                                        .scaleEffect(x: phase.isIdentity ? 1.0 : 0.3, y: phase.isIdentity ? 1.0 : 0.5)
                                        .offset(x: phase.isIdentity ? 0 : 50)
                                }
                        }
                    }
                    .scrollTargetLayout()
                }
                .contentMargins(12, for: .scrollContent)
                .scrollTargetBehavior(.paging)
                
                HStack {
                    Text("Dla nas liczy się styl")
                        .font(.title)
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                    Spacer()
                }
                .padding(.leading)
                
                HStack {
                    Spacer()
                    
                    NavigationLink{
                       
                    } label: {
                        Text("Sprawdź opinie...")
                            .fontWeight(.bold)
                    }
                    .font(.system(size: 14))
                }
                .padding(.horizontal)

                .foregroundColor(Color(hex: 0x0B68D40))

                
                Spacer()
                
                VStack(alignment: .leading){
                    HStack {
                        Text("Nasze salony")
                            .font(.title)
                            .fontWeight(.bold)
                        
                        Spacer()
                        
                        Picker("Miasto", selection: $citySelection) {
                            ForEach(cities, id: \.self) { city in
                                Text(city)
                                    .fontWeight(.bold)
                                    .tag(city)
                                
                            }
                        }
                        .tint(.yellow)
                        
                        
                    }
                    
                    
                    SalonRowView(salon: Salon(ID: 0, name: "Atelier Paris", phoneNumber: "654-231-908", city: "Wrocław", street: "ul. Pl. Grunwaldzki", buildingNumber: "9", postalCode: "00-076"))
                    
                    SalonRowView(salon: Salon(ID: 0, name: "Atelier Lyon", phoneNumber: "654-231-908", city: "Warszawa", street: "ul. Koszykowa", buildingNumber: "56", postalCode: "00-076"))
                    
                    SalonRowView(salon: Salon(ID: 0, name: "Atelier Bordeaux", phoneNumber: "654-231-908", city: "Warszawa", street: "al. Jerozolimskie", buildingNumber: "30", postalCode: "00-076"))
                    
                    SalonRowView(salon: Salon(ID: 0, name: "Atelier Montpellier", phoneNumber: "654-231-908", city: "Wrocław", street: "ul. Pl. Grunwaldzki", buildingNumber: "9", postalCode: "00-076"))
                    
                    SalonRowView(salon: Salon(ID: 0, name: "Atelier Paris", phoneNumber: "654-231-908", city: "Wrocław", street: "ul. Pl. Grunwaldzki", buildingNumber: "9", postalCode: "00-076"))
                    
                    SalonRowView(salon: Salon(ID: 0, name: "Atelier Paris", phoneNumber: "654-231-908", city: "Wrocław", street: "ul. Pl. Grunwaldzki", buildingNumber: "9", postalCode: "00-076"))
                    
                    SalonRowView(salon: Salon(ID: 0, name: "Atelier Paris", phoneNumber: "654-231-908", city: "Wrocław", street: "ul. Pl. Grunwaldzki", buildingNumber: "9", postalCode: "00-076"))
                    
//                    SalonRowView(name: "Atelier Lyon",
//                              address: "ul. Buforowa 94",
//                              city: "Wrocław")
//                    
//                    SalonRowView(name: "Atelier Bordeaux",
//                              address: "al. Jerozolimskie 34",
//                              city: "Warszawa")
//                    
//                    SalonRowView(name: "Atelier Bordeaux",
//                              address: "al. Jerozolimskie 34",
//                              city: "Warszawa")
//                    
//                    SalonRowView(name: "Atelier Bordeaux",
//                              address: "al. Jerozolimskie 34",
//                              city: "Warszawa")
//                    
//                    SalonRowView(name: "Atelier Bordeaux",
//                              address: "al. Jerozolimskie 34",
//                              city: "Warszawa")
//                    
//                    SalonRowView(name: "Atelier Bordeaux",
//                              address: "al. Jerozolimskie 34",
//                              city: "Warszawa")
//                    
//                    SalonRowView(name: "Atelier Bordeaux",
//                              address: "al. Jerozolimskie 34",
//                              city: "Warszawa")
                    
                    
                    
                }
                .padding()
                
                
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
    }
}

#Preview {
    HomeView()
}
