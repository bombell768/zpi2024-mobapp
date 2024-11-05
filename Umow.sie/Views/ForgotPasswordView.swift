//
//  ForgotPasswordView.swift
//  Umow.sie
//
//  Created by Bartosz Strzecha on 15/10/2024.
//

import SwiftUI

struct ForgotPasswordView: View {
    @State private var email: String = ""
    
    var body: some View {
        VStack{
            Text("Resetowanie hasła")
                .font(.title)
                .fontWeight(.bold)
                .padding(.vertical, 20)
            
            Spacer()
            .frame(height: 20)
            VStack{
                VStack(spacing: 24){
                    InputView(text: $email,
                              title: "Wprowadź swój adres e-mail",
                              placeholder: "")
                    .autocapitalization(.none)
                }
                .padding(.horizontal)
                .padding(.top, 12)
            }
            
            Button {
                print("Reset password...")
            } label: {
                HStack {
                    Text("Zresetuj hasło")
                        .fontWeight(.bold)
                }
                .foregroundColor(.white)
                .frame(width: UIScreen.main.bounds.width - 32, height: 48)
            }
            .background(Color(hex: 0x0B68D40))
            .cornerRadius(10)
            .padding(.top, 20)
            
            Spacer()
            
            
            
        }
    }
}

#Preview {
    ForgotPasswordView()
}
