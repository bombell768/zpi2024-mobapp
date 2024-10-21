//
//  AuthService.swift
//  Umow.sie
//
//  Created by Bartosz Strzecha on 20/10/2024.
//

import Foundation

enum AuthenticationError: Error {
    case invalidCredentials
    case custom(errorMessage: String)
}

struct LoginRequestBody: Codable {
    let email: String
    let password: String
}

struct LoginResponse: Codable {
    let token: String?
    let message: String?
    let success: Bool?
}
class AuthService {
    
    func login(username: String, password: String, completion: @escaping (Result<String, AuthenticationError>) -> Void) {
        
        guard let url = URL(string: APIEndpoints.loginClient) else {
            completion(.failure(.custom(errorMessage: "Invalid URL")))
            return
        }
        
        let body = LoginRequestBody(email: username, password: password)

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONEncoder().encode(body)
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data, error == nil else {
                completion(.failure(.custom(errorMessage: "No data")))
                return
            }

            // token teraz
            guard let responseBody = String(data: data, encoding: .utf8) else {
                print("Unable to convert response body to string")
                return
            }
            
//            guard let loginResponse = try? JSONDecoder().decode(LoginResponse.self, from: data) else {
//                completion(.failure(.invalidCredentials))
//                return
//            }
//            
//            guard let token = loginResponse.token else {
//                    completion(.failure(.invalidCredentials))
//                    return
//            }
                           
            completion(.success(responseBody))
                           
        }.resume()
    }
    
    func register(client: Client, completion: @escaping (Result<String, AuthenticationError>) -> Void) {
        
        guard let url = URL(string: APIEndpoints.registerClient) else {
            completion(.failure(.custom(errorMessage: "Invalid URL")))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONEncoder().encode(client)
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data, error == nil else {
                completion(.failure(.custom(errorMessage: "No data")))
                return
            }
            
            // token teraz
            guard let responseBody = String(data: data, encoding: .utf8) else {
                print("Unable to convert response body to string")
                return
            }
            
            //            guard let loginResponse = try? JSONDecoder().decode(LoginResponse.self, from: data) else {
            //                completion(.failure(.invalidCredentials))
            //                return
            //            }
            //
            //            guard let token = loginResponse.token else {
            //                    completion(.failure(.invalidCredentials))
            //                    return
            //            }
            
            completion(.success(responseBody))
            
        }.resume()
    }
    
}
