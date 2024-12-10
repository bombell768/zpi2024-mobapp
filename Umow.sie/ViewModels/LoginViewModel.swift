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
    var isLoggingIn: Bool = false
    
    var isLoggedIn: Bool {
        get {
            UserDefaults.standard.bool(forKey: "isLoggedIn")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "isLoggedIn")
        }
    }

    var authToken: String? {
        get {
            UserDefaults.standard.string(forKey: "authToken")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "authToken")
        }
    }
    
    var userId: Int? {
        get {
            UserDefaults.standard.integer(forKey: "userID")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "userID")
        }
    }
   
    var errorMessage: String?
    
    func login(username: String, password: String, role: UserRole) {
        print("Loguje z rolą: \(role.rawValue)")
        isLoggingIn = true
        AuthService().login(email: username, password: password, role: role) {result in
            DispatchQueue.main.async {
                switch result {
                case .success(let token):
                    self.authToken = token.token
                    self.isLoggingIn = false
                    self.isLoggedIn = true
                    
                    print(token)
                    
                    if let userId = self.decodeTokenAndGetUserId(from: token.token) {
                        self.userId = userId
                        print("User ID: \(userId)")
                    }
                    
                case .failure(let error):
                    self.isLoggingIn = false
                    self.errorMessage = error.localizedDescription
                    print(self.errorMessage ?? "Unknown error")
                }
            }
        }

    }

    private func decodeTokenAndGetUserId(from token: String) -> Int? {
       let components = token.split(separator: ".")
       
       guard components.count == 3 else {
           print("Invalid token format")
           return nil
       }
       
       let payloadBase64Url = components[1]
       let base64Url = payloadBase64Url.replacingOccurrences(of: "-", with: "+").replacingOccurrences(of: "_", with: "/")
       
       let paddingLength = base64Url.count % 4
       let base64 = base64Url + String(repeating: "=", count: paddingLength)
       
       if let data = Data(base64Encoded: base64), let json = try? JSONSerialization.jsonObject(with: data, options: []), let dictionary = json as? [String: Any] {
           return dictionary["userId"] as? Int
       }
       
       return nil
   }
    
    

}
