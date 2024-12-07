//
//  ProfileView.swift
//  Umow.sie
//
//  Created by Bartosz Strzecha on 05/12/2024.
//

import SwiftUI

struct ProfileView: View {
    
    @State var viewModel: ProfileViewModel = ProfileViewModel()
    
    @AppStorage("clientID") private var clientID: Int?
    
    var body: some View {
        NavigationStack {
            VStack (alignment: .leading, spacing: 20) {
                HStack(alignment: .center) {
                    Spacer()
                    
                    Button {
                        UserDefaults.standard.set(false, forKey: "isClientLoggedIn")
                        UserDefaults.standard.set(false, forKey: "isEmployeeLoggedIn")
                        UserDefaults.standard.set(nil, forKey: "authToken")
                        print(UserDefaults.standard.bool(forKey: "isClientLoggedIn"))
                    } label: {
                        HStack {
                            Text("Wyloguj")
                                .fontWeight(.bold)
                        }
                        .foregroundColor(.black)
                        .frame(width: 110, height: 38)
                        
                    }
                    .background(Color.ui.vanilla)
                    .cornerRadius(10)
                    
                }


                Text(viewModel.client.name + " " + viewModel.client.surname)
                    .font(.title)
                    .fontWeight(.bold)
                
                

                
                VStack(alignment:.leading, spacing: 20) {
                    Text("Konto")
                        .font(.title2)
                        .fontWeight(.bold)
                    
                    HStack {
                        Text("Email: \(viewModel.client.email)")
                            .font(.system(size: 18))
                        Spacer()
                        Image(systemName: "pencil")
                            .font(.system(size: 22))
                            .foregroundStyle(Color.ui.vanilla)
                            .onTapGesture {
                                viewModel.isEditingEmail.toggle()
                            }

                    }
                    
                    HStack {
                        Text("Numer telefonu: \(viewModel.client.phoneNumber)")
                            .font(.system(size: 18))
                        Spacer()
                        Image(systemName: "pencil")
                            .font(.system(size: 22))
                            .foregroundStyle(Color.ui.vanilla)
                            .onTapGesture {
                                viewModel.isEditingPhoneNumber.toggle()
                            }
                    }
                    
//                    HStack {
//                        Text("Preferowane usługi: \(viewModel.client.preferredService)")
//                            .font(.system(size: 18))
//                        Spacer()
//                        Image(systemName: "pencil")
//                            .font(.system(size: 22))
//                    }
                    
                    HStack {
                        Spacer()
                        Text("Zmień hasło")
                            .foregroundStyle(Color.ui.vanilla)
                            .fontWeight(.semibold)
                            .font(.system(size: 18))
                    }
                    .padding(.top)
                }
                
                Divider()
                    .frame(height: 1)
                    .overlay(Color.ui.vanilla)
                    
                VStack(alignment: .leading, spacing: 36) {
                    Text("Twoje pieczątki")
                        .font(.title2)
                        .fontWeight(.bold)
                
                    StampView(earnedStamps: viewModel.numberOfSeals)
                }
                

                Spacer()
            }
            .padding()

        }
        .onAppear {
            viewModel.getNumberOfSeals(clientId: clientID ?? 0)
            viewModel.getClientById(clientId: clientID ?? 0)
        }
        
        .sheet(isPresented: $viewModel.isEditingEmail) {
            EditDataView(
                viewTitle: "Zmiana adresu email",
                inputTitle: "Nowy adres email",
                onSave: { newEmail in
                    viewModel.updateClientEmail(newEmail: newEmail)
                }
            )
                .presentationBackground(Color.black)
        }

        .sheet(isPresented: $viewModel.isEditingPhoneNumber) {
            EditDataView(
                viewTitle: "Zmiana numeru telefonu",
                inputTitle: "Nowy numer telefonu",
                onSave: { newPhoneNumber in
                    viewModel.updateClientPhoneNumber(newPhoneNumber: newPhoneNumber)
                })
                .presentationBackground(Color.black)
        }
    }
}

#Preview {
    ProfileView()
}
