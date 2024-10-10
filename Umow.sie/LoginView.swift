//
//  LoginView.swift
//  Umow.sie
//
//  Created by Bartosz Strzecha on 08/10/2024.
//

import SwiftUI

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""

    var body: some View {
        NavigationStack {
            VStack {
                Image("rainbowlake")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .padding(.vertical, 32)
                  
                Spacer()
                
                VStack(spacing: 24){
                    InputView(text: $email,
                              title: "Adres e-mail",
                              placeholder: "jan.nowak23@gmail.com")
                    .autocapitalization(.none)
                    
                    InputView(text: $password,
                              title: "Hasło",
                              placeholder: "Wpisz swoje hasło",
                              isSecureField: true)
                }
                .padding(.horizontal)
                
                HStack {
                    Spacer()
                    NavigationLink{
                        
                    } label: {
                        Text("Nie pamiętam hasła")
                            .fontWeight(.bold)
                    }
                    .font(.system(size: 14))
                }
                .padding(.horizontal)
                .padding(.top, 10)
                
                
                Button {
                    print("Log user in...")
                } label: {
                    HStack {
                        Text("Zaloguj się")
                            .fontWeight(.bold)
                        Image(systemName: "arrow.right")
                    }
                    .foregroundColor(.white)
                    .frame(width: UIScreen.main.bounds.width - 32, height: 48)
                }
                .background(Color(.systemBlue))
                .cornerRadius(10)
                .padding(.top, 20)
                // test
                
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
                }
            }
        }
    }
}

//test 2

#Preview {
    LoginView()
}
