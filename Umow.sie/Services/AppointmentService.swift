//
//  AppointmentService.swift
//  Umow.sie
//
//  Created by Bartosz Strzecha on 20/11/2024.
//

import Foundation

struct EmployeeRequestBody: Codable {
    let salonID: Int
    let serviceIds: [Int]
}


protocol AppointmentServiceProtocol {
    func getEmployees(salonId: Int, serviceIds: [Int], completion: @escaping (Result<[Employee], Error>) -> Void)
    func getAvailabilityDates(salonId: Int, employeeID: Int, completion: @escaping (Result<[Date], Error>) -> Void)
}

class AppointmentService: AppointmentServiceProtocol {
    
    func getEmployees(salonId: Int, serviceIds: [Int], completion: @escaping (Result<[Employee], Error>) -> Void) {
        
        let url = URL(string: APIEndpoints.getEmployees)!
        
        let body = EmployeeRequestBody(salonID: salonId, serviceIds: serviceIds)

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONEncoder().encode(body)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
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
                let employees = try decoder.decode([Employee].self, from: data)
//                print(employees)
                completion(.success(employees))
                
            } catch {
                completion(.failure(error))
            }
                           
        }.resume()
    }
    
    
    func getAvailabilityDates(salonId: Int, employeeID: Int, completion: @escaping (Result<[Date], Error>) -> Void) {
        
        let urlString = APIEndpoints.getAvailabilityDates + String(salonId) + "/" + String(employeeID)
        
        let url = URL(string: urlString)!
        
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
                let dates = try decoder.decode([Date].self, from: data)

                completion(.success(dates))
                
            } catch {
                completion(.failure(error))
            }
        }.resume()
        
    }
    
}
