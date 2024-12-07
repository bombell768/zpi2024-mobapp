//
//  LoginView.swift
//  Umow.sie
//
//  Created by Bartosz Strzecha on 08/10/2024.
//

import SwiftUI

struct LoginView: View {
    
    @State private var viewModel = LoginViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                Image("logoZPI-2")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 350, height: 350)
                    .cornerRadius(20)
                    .padding(.vertical, 32)
                
                Spacer()
                
                if viewModel.isUserEmployee {
                    Text("Panel pracownika")
                        .font(.title)
                        .fontWeight(.bold)
                        .padding(.bottom, 30)
                }
                     
                VStack(spacing: 16){
                    InputView(text: $viewModel.username,
                              title: "Adres e-mail",
                              placeholder: "")
                    .autocapitalization(.none)
                    
                    InputView(text: $viewModel.password,
                              title: "Hasło",
                              placeholder: "",
                              isSecureField: true)
                }
                .padding(.horizontal)
                
                HStack {
                    Spacer()
                    NavigationLink{
                        ForgotPasswordView()
                    } label: {
                        Text("Nie pamiętam hasła")
                            .fontWeight(.bold)
                    }
                    .font(.system(size: 14))
                }
                .padding(.horizontal)
                .padding(.top, 10)
                .foregroundColor(Color.ui.vanilla)
                
                
                VStack(spacing: 30) {
                    Button {
                        print("Log user in...")
                        viewModel.login(username: viewModel.username, password: viewModel.password, isEmployee: viewModel.isUserEmployee)
                        
                        
                    } label: {
                        HStack {
                            Text("Zaloguj się")
                                .fontWeight(.bold)
                            Image(systemName: "arrow.right")
                        }
                        .foregroundColor(.black.opacity(0.9))
                        .frame(width: UIScreen.main.bounds.width - 32, height: 48)
                    }
                    .background(Color.ui.vanilla)
                    .cornerRadius(10)
                    .padding(.top, 20)
                    
                   
                    
                    VStack(spacing: 10) {
                        if !viewModel.isUserEmployee {
                            NavigationLink{
                                RegistrationView()
                                    .navigationBarBackButtonHidden(true)
                            } label: {
                                HStack(spacing: 3) {
                                    Text("Nie masz jeszcze konta?")
                                    Text("Zarejestruj się")
                                        .fontWeight(.bold)
                                }
                                .font(.system(size: 14))
                                .foregroundColor(Color.ui.vanilla)
                            }
                            
                            
                            Button {
                                viewModel.isUserEmployee = true
                            } label: {
                                HStack(spacing: 3) {
                                    Text("Jestem pracownikiem")
                                        .fontWeight(.bold)
                                }
                                .font(.system(size: 14))
                                .foregroundColor(Color.ui.vanilla)
                            }
                        }
                        
                        if viewModel.isUserEmployee {
                            Button {
                                viewModel.isUserEmployee = false
                            } label: {
                                HStack(spacing: 3) {
                                    Text("Jestem klientem")
                                        .fontWeight(.bold)
                                }
                                .font(.system(size: 14))
                                .foregroundColor(Color.ui.vanilla)
                            }
                        }
                    }
                }
                
                
                
                
            }
            .navigationDestination(isPresented: $viewModel.isClientLoggedIn){
                MainView()
                    .navigationBarBackButtonHidden(true)
            }
        }
 
    }
}


#Preview {
    LoginView()
}
