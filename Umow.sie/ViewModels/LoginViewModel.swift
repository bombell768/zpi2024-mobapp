//
//  LoginViewModel.swift
//  Umow.sie
//
//  Created by Bartosz Strzecha on 20/10/2024.
//

import Foundation
import SwiftUI
import Observation

@Observable class LoginViewModel {
    
    var username: String = ""
    var password: String = ""
    var isLoggedIn: Bool = false
    
    func login() {
        print("Logging in with username: \(username), password: \(password)")
        
        AuthService().login(username: username, password: password) { result in
            switch result {
            case .success(let token):
                print("Logged in with token: \(token)")
                DispatchQueue.main.async {
                    self.isLoggedIn = true
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
