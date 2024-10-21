//
//  RegistrationView.swift
//  Umow.sie
//
//  Created by Bartosz Strzecha on 08/10/2024.
//

import SwiftUI

struct RegistrationView: View {
    
    @State private var vm = RegistrationViewModel()
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack{
            Text("Rejestracja")
                .font(.title)
                .fontWeight(.bold)
                .padding(.vertical, 32)
            
            
            VStack{
                VStack(spacing: 15){
                    InputView(text: $vm.firstName,
                              title: "Imię",
                              placeholder: "Jan")
                    
                    InputView(text: $vm.sureName,
                              title: "Nazwisko",
                              placeholder: "Nowak")
                    
                    InputView(text: $vm.email,
                              title: "Adres e-mail",
                              placeholder: "jan.nowak23@gmail.com")
                    .autocapitalization(.none)
                    
                    InputView(text: $vm.phoneNumber,
                              title: "Numer telefonu",
                              placeholder: "528 123 456")
                    
                    InputView(text: $vm.password,
                              title: "Hasło",
                              placeholder: "Wpisz swoje hasło",
                              isSecureField: true)
                    
                    InputView(text: $vm.confirmPassword,
                              title: "Potwierdź hasło",
                              placeholder: "Wpisz swoje hasło ponownie",
                              isSecureField: true)
                    
                    HStack {
                        Text("Wybierz preferencje usług")
                            .font(.footnote)
                            .foregroundColor(Color(.darkGray))
                            .fontWeight(.semibold)
                        Spacer()
                    }
                        
                    
                    Picker("Preferencje usług", selection: $vm.serviceSelection) {
                        Text("Mężczyna").tag(0)
                        Text("Kobieta").tag(1)
                        Text("Wszystkie").tag(2)
                    }
                    .pickerStyle(.segmented)
                    
                    
                }
                .padding(.horizontal)
                .padding(.top, 12)

            }
            
            
            Button {
                vm.register()
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
            .padding(.top, 30)
            
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
