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
    func updateClient(client: Client, completion: @escaping (Result<String, Error>) -> Void)
    func getEmployeeById(employeeId: Int, completion: @escaping (Result<Employee, Error>) -> Void)
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
    
    func getEmployeeById(employeeId: Int, completion: @escaping (Result<Employee, Error>) -> Void) {
        
        let urlString = APIEndpoints.getEmployeeById + String(employeeId)
        
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
                let decoder = JSONDecoder.withFormattedDates
                let employee = try decoder.decode(Employee.self, from: data)
                print("Client: \(employee)")
                completion(.success(employee))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
    
    
    func updateClient(client: Client, completion: @escaping (Result<String, Error>) -> Void) {
        
        let urlString = APIEndpoints.updateClient
        
        guard let url = URL(string: urlString) else {
            completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        do {
           let jsonData = try JSONEncoder().encode(client)
           request.httpBody = jsonData
        } catch {
           completion(.failure(error))
           return
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
                completion(.success("Client updated successfully"))
            case 404:
                completion(.failure(NSError(domain: "", code: 404, userInfo: [NSLocalizedDescriptionKey: "Client not found"])))
            case 400:
                completion(.failure(NSError(domain: "", code: 400, userInfo: [NSLocalizedDescriptionKey: "Invalid client data"])))
            default:
                let errorDescription = HTTPURLResponse.localizedString(forStatusCode: httpResponse.statusCode)
                completion(.failure(NSError(domain: "", code: httpResponse.statusCode, userInfo: [NSLocalizedDescriptionKey: errorDescription])))
            }
        }.resume()
    }
}
