//
//  RegistrationViewModel.swift
//  Umow.sie
//
//  Created by Bartosz Strzecha on 21/10/2024.
//

import Foundation
import SwiftUI

@Observable class RegistrationViewModel {
    
    var firstName = ""
    var sureName = ""
    var email = ""
    var phoneNumber = ""
    var password = ""
    var confirmPassword = ""
    var serviceSelection = 2
    
    var errorMessage: String? = nil
    var isRegistrationSuccessful: Bool = false
    var isRegistrationDone: Bool = false
    
    private let authService: AuthService
    
    init(authService: AuthService = AuthService()) {
        self.authService = authService
    }

    func register() {
        guard password == confirmPassword else {
            errorMessage = "Passwords do not match."
            return
        }
        let phoneNumberWithPrefix = "+48 " + phoneNumber
        
        let client = Client (
            id: 0,
            name: firstName,
            surname: sureName,
            phoneNumber: phoneNumberWithPrefix,
            email: email,
            password: password,
            preferredService: serviceSelection
        )
        
        
        errorMessage = nil
        
        authService.registerClient(client: client) { [weak self] result in
            DispatchQueue.main.async {
                self?.isRegistrationDone = false
                switch result {
                case .success:
                    self?.isRegistrationSuccessful = true
                    self?.isRegistrationDone = true
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                    self?.isRegistrationDone = true
                    print(self?.errorMessage ?? "Nieznany błąd")
                }
            }
        }
    }
}
