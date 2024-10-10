//
//  RegistrationView.swift
//  Umow.sie
//
//  Created by Bartosz Strzecha on 08/10/2024.
//

import SwiftUI

struct RegistrationView: View {
    @State private var firstName = ""
    @State private var sureName = ""
    @State private var email = ""
    @State private var phoneNumber = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack{
            Text("Rejestracja")
                .font(.title)
                .fontWeight(.bold)
                .padding(.vertical, 32)
            
            
            VStack{
                VStack(spacing: 24){
                    InputView(text: $firstName,
                              title: "Imię",
                              placeholder: "Jan")
                    
                    InputView(text: $sureName,
                              title: "Nazwisko",
                              placeholder: "Nowak")
                    
                    InputView(text: $email,
                              title: "Adres e-mail",
                              placeholder: "jan.nowak23@gmail.com")
                    .autocapitalization(.none)
                    
                    InputView(text: $phoneNumber,
                              title: "Numer telefonu",
                              placeholder: "528 123 456")
                    
                    InputView(text: $password,
                              title: "Hasło",
                              placeholder: "Wpisz swoje hasło",
                              isSecureField: true)
                    
                    InputView(text: $confirmPassword,
                              title: "Potwierdź hasło",
                              placeholder: "Wpisz swoje hasło ponownie",
                              isSecureField: true)
                    
                    // TODO: preferowane uslugi
                    
                    
                }
                .padding(.horizontal)
                .padding(.top, 12)
            }
            
            Button {
                print("Sign user up...")
            } label: {
                HStack {
                    Text("Zarejestruj się")
                        .fontWeight(.bold)
                    Image(systemName: "arrow.right")
                }
                .foregroundColor(.white)
                .frame(width: UIScreen.main.bounds.width - 32, height: 48)
            }
            .background(Color(.systemBlue))
            .cornerRadius(10)
            .padding(.top, 20)
            
            Spacer()
            
            Button{
                dismiss()
            } label:{
                HStack(spacing: 3) {
                    Text("Masz już konto?")
                    Text("Zaloguj się")
                        .fontWeight(.bold)
                }
                .font(.system(size: 14))
            }
        }
    }
}

#Preview {
    RegistrationView()
}
