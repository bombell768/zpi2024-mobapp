//
//  ProfileView.swift
//  Umow.sie
//
//  Created by Bartosz Strzecha on 05/12/2024.
//

import SwiftUI

struct ProfileView: View {
    
    @State var viewModel: ProfileViewModel = ProfileViewModel()
    
    @AppStorage("userID") private var userID: Int?
    @AppStorage("isLoggedIn") private var isLoggedIn: Bool?
    @AppStorage("authToken") private var authToken: String?
    @AppStorage("userRole") private var userRole: UserRole?
    
    var body: some View {
        NavigationStack {
            VStack (alignment: .leading, spacing: 20) {
                HStack(alignment: .center) {
                    Spacer()
                    
                    Button {
                        isLoggedIn = false
                        authToken = nil
                        print(UserDefaults.standard.bool(forKey: "isLoggedIn"))
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


                if userRole == .client {
                    Text(viewModel.client.name + " " + viewModel.client.surname)
                        .font(.title)
                        .fontWeight(.bold)
                }
                else if userRole == .employee {
                    Text(viewModel.employee.name + " " + viewModel.employee.surname)
                        .font(.title)
                        .fontWeight(.bold)
                    
                    Text("Jesteś zalogowany jako pracownik.")
                        .font(.subheadline)
                        
                }
                
                

                
                VStack(alignment:.leading, spacing: 20) {
                    if userRole == .client {
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
                    
                if userRole == .client {
                    Divider()
                        .frame(height: 1)
                        .overlay(Color.ui.vanilla)
                    
                    VStack(alignment: .leading, spacing: 36) {
                        Text("Twoje pieczątki")
                            .font(.title2)
                            .fontWeight(.bold)
                        
                        StampView(earnedStamps: viewModel.numberOfSeals)
                    }
                }
                

                Spacer()
            }
            .padding()

        }
        .onAppear {      
            if userRole == .client {
                viewModel.getNumberOfSeals(clientId: userID ?? 0)
                viewModel.getClientById(clientId: userID ?? 0)
            }
            else if userRole == .employee {
                viewModel.getEmployeeById(employeeId: userID ?? 0)
            }
            
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
