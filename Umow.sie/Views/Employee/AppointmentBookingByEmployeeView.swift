//
//  AppointmentBookingByEmployeeView.swift
//  Umow.sie
//
//  Created by Bartosz Strzecha on 07/12/2024.
//

import SwiftUI

struct AppointmentBookingByEmployeeView: View {
    @State private var email: String = ""
    @State private var salons: [Salon] = []
    @State private var selectedSalon: Salon? = nil
    @State private var isClientConfirmed: Bool = false
    @State private var isNavigationActive: Bool = false
    
    @State private var viewModel = AppointmentBookingViewModel()
    
    @AppStorage("choosenClientID") private var choosenClientID: Int?
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                VStack(alignment: .leading, spacing: 10) {
                    Text("Wpisz adres email klienta")
                        .font(.headline)
                        .padding(.top, 12)
                    
                    VStack(spacing: 14) {
                        TextField("", text: $email)
                            .padding(10)
                            .background(
                                RoundedRectangle(cornerRadius: 8)
                                    .fill(Color.ui.cultured)
                            )
                            .keyboardType(.emailAddress)
                            .autocapitalization(.none)
                        
                        Button(action: {
                            viewModel.getClientByEmail(email: email)
                            isClientConfirmed = false
                        }) {
                            Text("Szukaj")
                                .frame(width: 150, height: 48)
                                .background(Color.ui.vanilla)
                                .foregroundColor(.black.opacity(0.9))
                                .fontWeight(.semibold)
                                .cornerRadius(10)
                            
                        }
                        .disabled(email.isEmpty || viewModel.isCheckingEmail)
                    }
                    .padding(.bottom, 10)
                    
                    
                    if let client = viewModel.client {
                        HStack {
                            VStack(alignment: .leading) {
                                Text("\(client.name) \(client.surname)")
                                    .font(.system(size: 20))
                                    .fontWeight(.semibold)
                                
                                Text("\(client.phoneNumber)")
                            }
                            Spacer()
                            
                            Button("Wybierz") {
                                isClientConfirmed = true
                                choosenClientID = viewModel.client?.id
                            }
                            .frame(width: 100, height: 40)
                            .background(isClientConfirmed ? Color.gray : Color.ui.vanilla)
                            .foregroundColor(.black.opacity(0.9))
                            .fontWeight(.semibold)
                            .cornerRadius(10)
                            .disabled(isClientConfirmed)
                        }
                    } else if let errorMessage = viewModel.errorMessage {
                        Text(errorMessage)
                            .foregroundColor(.red)
                    }
                }
                .padding(.horizontal)
                .padding(.bottom, 20)
                
               
                if isClientConfirmed {
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Wybierz salon")
                            .font(.headline)
                        
                        ScrollView {
                            ForEach(viewModel.salons, id: \.id) { salon in
                                HStack {
                                    VStack(alignment: .leading) {
                                        Text(salon.name)
                                            .font(.headline)
                                            .fontWeight(.semibold)
                                        Text(salon.street + " " + salon.buildingNumber)
                                            .font(.caption)
                                        Text(salon.city)
                                            .font(.caption)
                                    }
                                    
                                    Spacer()
                                    
                                    if selectedSalon == salon {
                                        Image(systemName: "checkmark.circle.fill")
                                            .foregroundColor(Color.ui.vanilla)
                                    }
                                }
                                .padding()
                                .background(selectedSalon == salon ? Color.ui.vanilla.opacity(0.2) : Color.gray.opacity(0.1))
                                .cornerRadius(10)
                                .onTapGesture {
                                    selectedSalon = salon
                                }
                            }
                        }
                    }
                    .padding(.horizontal)
                }
                
                Spacer()
                
                
                if selectedSalon != nil && viewModel.client != nil {
                    NavigationLink {
                        SalonDetailView(salon: selectedSalon ?? Salon(), viewModel: SalonDetailViewModel())
                    } label: {
                        Text("Przejdź dalej")
                            .font(.headline)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(selectedSalon != nil && viewModel.client != nil ? Color.ui.vanilla : Color.gray)
                            .foregroundColor(.black.opacity(0.9))
                            .cornerRadius(10)
                    }
                    .disabled(selectedSalon == nil || viewModel.client == nil)
                    .padding(.horizontal)
                    
                }
            }
            .padding(.bottom)
            .navigationTitle("Umów klienta")
            .navigationBarBackButtonHidden(true)
//            .navigationDestination(isPresented: $isNavigationActive) {
//                
//            }
        }
        .onAppear {
            viewModel.fetchSalons()
            print("isNavigationActive on start: \(isNavigationActive)")
        }
        .onChange(of: isNavigationActive) { oldValue, newValue in
            print("Navigation active change: \(newValue)")
            
        }
    }
    
    
    private func confirmSelection() {
        print("Client: \(viewModel.client?.name ?? "None"), Salon: \(selectedSalon?.name ?? "None")")
    }
}

#Preview {
    AppointmentBookingByEmployeeView()
}
