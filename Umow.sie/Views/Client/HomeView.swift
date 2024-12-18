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
    
    @State private var viewModel = HomeViewModel()

    var body: some View {
        NavigationStack {
            ScrollView {
                
                Image("toolbarlogo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 320)
                    .cornerRadius(5)
                    .padding(.top, 12)

//                ScrollView (.horizontal) {
//                    HStack {
//                        ForEach(HomeImages.allCases, id: \.self) { image in
//                            Image(image.rawValue)
//                                .resizable()
//                                .scaledToFill()
////                                .frame(width: 300, height: 200)
//                                .cornerRadius(10)
//                                .containerRelativeFrame(.horizontal, count: 1, spacing: 1)
//                                .scrollTransition { content, phase in
//                                    content
//                                        .opacity(phase.isIdentity ? 1.0 : 0.5)
//                                        .scaleEffect(x: phase.isIdentity ? 1.0 : 0.3, y: phase.isIdentity ? 1.0 : 0.5)
//                                        .offset(x: phase.isIdentity ? 0 : 50)
//                                }
//                        }
//                    }
//                    .scrollTargetLayout()
//                }
//                .contentMargins(12, for: .scrollContent)
//                .scrollTargetBehavior(.paging)
                
                VStack {
                    TabView(selection: $viewModel.currentPhotoIndex) {
                        ForEach(Array(HomeImages.allCases.enumerated()), id: \.offset) { index, image in
                            Image(image.rawValue)
                                .resizable()
                                .scaledToFill()
                                .tag(index)
                        }
                    }
                    .tabViewStyle(.page(indexDisplayMode: .never))
                    .frame(height: 250)
                    .cornerRadius(10)
                    
                    HStack(spacing: 8) {
                       ForEach(HomeImages.allCases.indices, id: \.self) { index in
                           Circle()
                               .fill(index == viewModel.currentPhotoIndex ? Color.ui.vanilla : Color.ui.cultured)
                               .frame(width: 8, height: 8)
                               .scaleEffect(index == viewModel.currentPhotoIndex ? 1.2 : 1.0)
                               .animation(.spring(), value: viewModel.currentPhotoIndex)
                       }
                   }
                   .padding(.top, 10)
                }
                .padding()
               
                
//                HStack {
//                    Text("Dla nas liczy się styl")
//                        .font(.title)
//                        .fontWeight(.bold)
//                    Spacer()
//                }
//                .padding(.leading)
                
//                HStack {
//                    Spacer()
//                    
//                    NavigationLink{
//                       
//                    } label: {
//                        Text("Sprawdź opinie...")
//                            .fontWeight(.semibold)
//                    }
//                    .font(.system(size: 14))
//                }
//                .padding(.horizontal)
//                .foregroundStyle(Color.ui.black)

                
                Spacer()
                
                VStack(alignment: .leading){
                    HStack {
                        Text("Nasze salony")
                            .font(.title)
                            .fontWeight(.bold)
                        
                        Spacer()
                        
                        Picker("Miasto", selection: $viewModel.citySelection) {
                            ForEach(viewModel.cities, id: \.self) { city in
                                Text(city)
                                    .fontWeight(.bold)
                                    .tag(city)
                                
                            }
                        }
                        .tint(Color.ui.vanilla)
                        
                        
                    }
                    
                    ForEach(viewModel.salons.filter { salon in
                            viewModel.citySelection == "Wszystkie" || salon.city == viewModel.citySelection
                        }) { salon in
                            SalonRowView(salon: salon)
                        }
                    
                }
                .padding()
                
                
                
            }
            
        }
        .onAppear() {
            viewModel.fetchSalons()
        }
        .overlay(
            Group {
                if viewModel.isLoading {
                    ProgressView("Ładowanie...")
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(.black)
                }
            }
        )
        .onChange(of: viewModel.isLoading) {
            viewModel.getSalons()
        }
    }
}

#Preview {
    HomeView()
}
