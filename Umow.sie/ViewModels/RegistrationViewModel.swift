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
    
    func register() {
        let client = Client(id: 0, name: firstName, surname: sureName, phoneNumber: phoneNumber, email: email, password: password, preferredService: serviceSelection)
        
        if password == confirmPassword {
            print("Signing up with username: \(email), password: \(password)")
            AuthService().register(client: client) { result in
                switch result {
                case .success(let body):
                    print("Body: \(body)")
                case .failure(let error):
                    print(error)
                }
            }
        }
        else {
            print("Passwords do not match.")
        }
        
    }
}
