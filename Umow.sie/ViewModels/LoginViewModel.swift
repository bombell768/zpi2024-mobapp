//
//  LoginViewModel.swift
//  Umow.sie
//
//  Created by Bartosz Strzecha on 20/10/2024.
//

import Foundation
import SwiftUI

@Observable class LoginViewModel {
    
    var username: String = ""
    var password: String = ""
    
    func login() {
        print("Logging in with username: \(username), password: \(password)")
        
        AuthService().login(username: username, password: password) { result in
            switch result {
            case .success(let token):
                print("Logged in with token: \(token)")
            case .failure(let error):
                print(error)
            }
        }
    }
}
