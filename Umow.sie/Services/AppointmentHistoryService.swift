//
//  AppointmentHistoryService.swift
//  Umow.sie
//
//  Created by Bartosz Strzecha on 29/11/2024.
//

import Foundation

protocol AppointmentHistoryServiceProtocol {
    func getAllEmployeesByIds(employeesIds: [Int], completion: @escaping (Result<[Employee], Error>) -> Void)
    func getAllAppointmentsForCustomer(customerId: Int, completion: @escaping (Result<[AppointmentDTO], Error>) -> Void)
    func getServicesInAppointments(customerId: Int, completion: @escaping (Result<[ServicesInAppointment], Error>) -> Void)
    func getServicesByIds(servicesIds: [Int], completion: @escaping (Result<[Service], Error>) -> Void)
}

class AppointmentHistoryService: AppointmentHistoryServiceProtocol {
    
    func getAllEmployeesByIds(employeesIds: [Int], completion: @escaping (Result<[Employee], Error>) -> Void) {
        
        let urlString = APIEndpoints.getAllEmployeesByIds
        
        guard let url = URL(string: urlString) else {
            completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
            return
        }
        
        let body = employeesIds
        
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
            
            guard let data = data else {
                completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "No data"])))
                return
            }
            
            do {
                let decoder = JSONDecoder.withFormattedDates
                let employees = try decoder.decode([Employee].self, from: data)
                for employee in employees {
                    print(employee)
                }
                               
                completion(.success(employees))
                
            } catch {
                completion(.failure(error))
            }
            
        }.resume()
    }
        
    func getAllAppointmentsForCustomer(customerId: Int, completion: @escaping (Result<[AppointmentDTO], Error>) -> Void) {
        
        let urlString = APIEndpoints.getAllAppointmentsForCustomer + String(customerId)
        
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
                let appointments = try decoder.decode([AppointmentDTO].self, from: data)
//                for app in appointments {
//                    print(app)
//                }
                completion(.success(appointments))
                
            } catch {
                completion(.failure(error))
            }
                           
        }.resume()
    }
    
    func getServicesInAppointments(customerId: Int, completion: @escaping (Result<[ServicesInAppointment], Error>) -> Void) {
        
        let urlString = APIEndpoints.getServicesInAppointments + String(customerId)
        
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
                let servicesList = try JSONDecoder().decode([ServicesInAppointment].self, from: data)
//                for service in servicesList {
//                    print(service)
//                }
                completion(.success(servicesList))
                
            } catch {
                completion(.failure(error))
            }
                           
        }.resume()
    }
    
    func getServicesByIds(servicesIds: [Int], completion: @escaping (Result<[Service], Error>) -> Void) {
        
        let urlString = APIEndpoints.getAllServicesByIds
        
        guard let url = URL(string: urlString) else {
            completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
            return
        }
        
        let body = servicesIds
        
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
                let services = try decoder.decode([Service].self, from: data)
                
//                for service in services {
//                    print(service)
//                }
//                
                completion(.success(services))
                
            } catch {
                completion(.failure(error))
            }
            
        }.resume()
    }
}
