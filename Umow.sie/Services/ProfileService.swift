//
//  ProfileService.swift
//  Umow.sie
//
//  Created by Bartosz Strzecha on 06/12/2024.
//

import Foundation

protocol ProfileServiceProtocol {
    func getNumberOfCompletedAppointments(customerId: Int, completion: @escaping (Result<Int, Error>) -> Void)
    func getClientById(customerId: Int, completion: @escaping (Result<Client, Error>) -> Void)
}

class ProfileService: ProfileServiceProtocol {
    
    func getNumberOfCompletedAppointments(customerId: Int, completion: @escaping (Result<Int, Error>) -> Void) {
        
        let urlString = APIEndpoints.getNumberOfCompletedAppointments + String(customerId)
        
        guard let url = URL(string: urlString) else {
            completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "No data"])))
                return
            }
            
            do {
                let numberOfCompletedAppointments = try JSONDecoder().decode(Int.self, from: data)
                print("Number of completed appointments: \(numberOfCompletedAppointments)")
                completion(.success(numberOfCompletedAppointments))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
    
    func getClientById(customerId: Int, completion: @escaping (Result<Client, Error>) -> Void) {
        
        let urlString = APIEndpoints.getClientById + String(customerId)
        
        guard let url = URL(string: urlString) else {
            completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "No data"])))
                return
            }
            
            do {
                let client = try JSONDecoder().decode(Client.self, from: data)
                print("Client: \(client)")
                completion(.success(client))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
    
}
