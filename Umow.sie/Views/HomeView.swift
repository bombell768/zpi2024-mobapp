//
//  HomeView.swift
//  Umow.sie
//
//  Created by Bartosz Strzecha on 24/10/2024.
//

import SwiftUI

struct HomeView: View {
    @State var citySelection: String = "Wrocław"
    
    let cities: [String] = ["Wrocław", "Kraków", "Poznań", "Warszawa", "Szczecin", "Gdańsk", "Katowice"]
    
    
    var body: some View {
        NavigationStack {
            ScrollView {

                Image("toolbarlogo")
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: .infinity)
                    .cornerRadius(5)

                Image("vintage_barber_shop")
                    .resizable()
                    .scaledToFit()

                
                HStack {
                    Text("Dla nas liczy się styl")
                        .font(.title)
                        .foregroundColor(Color(hex: 0x0B68D40))
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
                        
                        
                    }
                    
                    
                    SalonView(name: "Atelier Paris",
                              address: "ul. Racławicka 1",
                              city: "Wrocław")
                    
                    SalonView(name: "Atelier Lyon",
                              address: "ul. Buforowa 94",
                              city: "Wrocław")
                    
                    SalonView(name: "Atelier Bordeaux",
                              address: "al. Jerozolimskie 34",
                              city: "Warszawa")
                    
                    SalonView(name: "Atelier Bordeaux",
                              address: "al. Jerozolimskie 34",
                              city: "Warszawa")
                    
                    SalonView(name: "Atelier Bordeaux",
                              address: "al. Jerozolimskie 34",
                              city: "Warszawa")
                    
                    SalonView(name: "Atelier Bordeaux",
                              address: "al. Jerozolimskie 34",
                              city: "Warszawa")
                    
                    SalonView(name: "Atelier Bordeaux",
                              address: "al. Jerozolimskie 34",
                              city: "Warszawa")
                    
                    SalonView(name: "Atelier Bordeaux",
                              address: "al. Jerozolimskie 34",
                              city: "Warszawa")
                    
                    
                    
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
