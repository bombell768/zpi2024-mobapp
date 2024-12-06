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
    var isLoading: Bool = false
    
    private let authService: AuthService
    
    init(authService: AuthService = AuthService()) {
        self.authService = authService
    }

    func register() {
        guard password == confirmPassword else {
            errorMessage = "Passwords do not match."
            return
        }
        
        let client = Client (
            id: 0,
            name: firstName,
            surname: sureName,
            phoneNumber: phoneNumber,
            email: email,
            password: password,
            preferredService: serviceSelection
        )
        
        isLoading = true
        errorMessage = nil
        
        authService.registerClient(client: client) { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success:
                    self?.isRegistrationSuccessful = true
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                    print(self?.errorMessage ?? "Unknown error")
                }
            }
        }
    }
}
