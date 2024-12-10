//
//  RegistrationView.swift
//  Umow.sie
//
//  Created by Bartosz Strzecha on 08/10/2024.
//

import SwiftUI

struct RegistrationView: View {
    
    @State private var viewModel = RegistrationViewModel()
    @Environment(\.dismiss) var dismiss
    
    @State private var showAlert: Bool = false
    @State private var alertMessage: String = ""
    
    var body: some View {
        VStack{
            Text("Rejestracja")
                .font(.title)
                .fontWeight(.bold)
                .padding(.vertical, 32)
            
            
            VStack{
                VStack(spacing: 15){
                    InputView(text: $viewModel.firstName,
                              title: "Imię",
                              placeholder: "Jan")
                    
                    InputView(text: $viewModel.sureName,
                              title: "Nazwisko",
                              placeholder: "Nowak")
                    
                    InputView(text: $viewModel.email,
                              title: "Adres e-mail",
                              placeholder: "jan.nowak23@gmail.com")
                    .autocapitalization(.none)
                    .keyboardType(.emailAddress)
                    
                    InputView(text: $viewModel.phoneNumber,
                              title: "Numer telefonu",
                              placeholder: "528 123 456")
                    .keyboardType(.phonePad)
                    
                    InputView(text: $viewModel.password,
                              title: "Hasło",
                              placeholder: "Wpisz swoje hasło",
                              isSecureField: true)
                    
                    InputView(text: $viewModel.confirmPassword,
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
                        
                    
                    Picker("Preferencje usług", selection: $viewModel.serviceSelection) {
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
                viewModel.register()
            } label: {
                HStack {
                    Text("Zarejestruj się")
                        .fontWeight(.bold)
                    Image(systemName: "arrow.right")
                }
                .foregroundColor(.black.opacity(0.9))
                .frame(width: UIScreen.main.bounds.width - 32, height: 48)
                
            }
            .background(Color.ui.vanilla)
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
                .foregroundColor(Color.ui.vanilla)
            }
        }
        .onChange(of: viewModel.isRegistrationDone) {
            if viewModel.isRegistrationSuccessful {
                alertMessage = "Rejestracja powiodła się. Zaloguj się na swoje konto."
            } else if let error = viewModel.errorMessage {
                alertMessage = error
            }
            showAlert = true
            viewModel.isRegistrationDone = false
        }
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text("Rejestracja"),
                message: Text(alertMessage),
                dismissButton: .default(Text("OK"), action: {
                    if viewModel.isRegistrationSuccessful {
                        dismiss()
                    }
                })
            )
        }
    }
}

#Preview {
    RegistrationView()
}
