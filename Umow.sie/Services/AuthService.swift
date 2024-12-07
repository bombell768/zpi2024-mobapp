//
//  AuthService.swift
//  Umow.sie
//
//  Created by Bartosz Strzecha on 20/10/2024.
//

import Foundation

class AuthService {
    
    func login(email: String, password: String, role: UserRole, completion: @escaping (Result<TokenDTO, Error>) -> Void) {
        let urlString: String
        
        switch role {
        case .client:
            urlString = APIEndpoints.loginClient
        case .employee:
            urlString = APIEndpoints.loginEmployee
        }
        
        guard let url = URL(string: urlString) else {
            completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
            return
        }
        
        let body = LoginDTO(email: email, password: password)

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONEncoder().encode(body)
        
        if let httpBody = request.httpBody,
               let bodyString = String(data: httpBody, encoding: .utf8) {
                print("Request body: \(bodyString)")
            }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid response"])))
                return
            }
            
            switch httpResponse.statusCode {
            case 200:
                guard let data = data else {
                    completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "No data received"])))
                    return
                }
                
                do {
                    let tokenDTO = try JSONDecoder().decode(TokenDTO.self, from: data)
                    completion(.success(tokenDTO))
                } catch {
                    completion(.failure(error))
                }
                
            case 400:
                completion(.failure(NSError(domain: "", code: 400, userInfo: [NSLocalizedDescriptionKey: "Bad Request"])))
                
            default:
                let errorDescription = HTTPURLResponse.localizedString(forStatusCode: httpResponse.statusCode)
                completion(.failure(NSError(domain: "", code: httpResponse.statusCode, userInfo: [NSLocalizedDescriptionKey: errorDescription])))
            }
        }.resume()
    }
    
    func registerClient(client: Client, completion: @escaping (Result<Void, Error>) -> Void) {
        
        let urlString =  APIEndpoints.registerClient
        
        guard let url = URL(string: urlString) else {
            completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
            return
        }
        
        let body = client

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONEncoder().encode(body)
        
        if let httpBody = request.httpBody {
            if let bodyString = String(data: httpBody, encoding: .utf8) {
                print("Body zapytania:")
                print(bodyString)
            } else {
                print("Nie udało się zdekodować danych body.")
            }
        } else {
            print("Zapytanie nie zawiera danych body.")
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid response"])))
                return
            }
            
            switch httpResponse.statusCode {
            case 200:
                completion(.success(()))
            case 400:
                let message = "Bad Request: Check client data or request format."
                completion(.failure(NSError(domain: "", code: httpResponse.statusCode, userInfo: [NSLocalizedDescriptionKey: message])))
            case 409:
                let message = "Conflict: Email already exists."
                completion(.failure(NSError(domain: "", code: httpResponse.statusCode, userInfo: [NSLocalizedDescriptionKey: message])))
            default: 
                let errorMessage = HTTPURLResponse.localizedString(forStatusCode: httpResponse.statusCode)
                completion(.failure(NSError(domain: "", code: httpResponse.statusCode, userInfo: [NSLocalizedDescriptionKey: errorMessage])))
            }
        }.resume()
    }
    
    
}
