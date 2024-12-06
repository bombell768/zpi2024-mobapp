//
//  LoginView.swift
//  Umow.sie
//
//  Created by Bartosz Strzecha on 08/10/2024.
//

import SwiftUI

struct LoginView: View {
    
    @State private var vm = LoginViewModel()
    
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
                
                VStack(spacing: 24){
                    InputView(text: $vm.username,
                              title: "Adres e-mail",
                              placeholder: "jan.nowak23@gmail.com")
                    .autocapitalization(.none)
                    
                    InputView(text: $vm.password,
                              title: "Hasło",
                              placeholder: "Wpisz swoje hasło",
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
                
                
                Button {
                    print("Log user in...")
                    vm.login(username: vm.username, password: vm.password)
                    
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
                
                Spacer()
                
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
            }
            .navigationDestination(isPresented: $vm.isLoggedIn){
                MainView()
                    .navigationBarBackButtonHidden(true)
            }
        }
 
    }
}


#Preview {
    LoginView()
}
