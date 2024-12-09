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
    func getOpeningHours(salonId: Int, completion: @escaping (Result<[OpeningHours], Error>) -> Void)
    func getTimeSlots(employeeId: Int, completion: @escaping (Result<[TimeSlot], Error>) -> Void)
    func saveAppointment(salonId: Int, employeeId: Int, customerId: Int, serviceIds: [Int], date: Date, timeStart: Time, completion: @escaping (Result<String, Error>) -> Void)
    func rescheduleAppointment(appointmentId: Int, userId: Int, userRole: String, date: Date, time: Time, completion: @escaping (Result<Void, Error>) -> Void)
    func getClientByEmail(email: String, completion: @escaping (Result<Client, Error>) -> Void)
}

class AppointmentBookingService: AppointmentServiceProtocol {
    
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
//                print("do zdekodowaniu: \(dates)")
                completion(.success(dates))
                
            } catch {
                completion(.failure(error))
            }
        }.resume()
        
    }
    
    func getOpeningHours(salonId: Int, completion: @escaping (Result<[OpeningHours], Error>) -> Void) {
        
        let urlString = APIEndpoints.getOpeningHours + String(salonId)
        
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
                let decoder = JSONDecoder()
                let openingHours = try decoder.decode([OpeningHours].self, from: data)
                
                completion(.success(openingHours))
                
            } catch {
                completion(.failure(error))
            }
        }.resume()
        
    }
    
    func getTimeSlots(employeeId: Int, completion: @escaping (Result<[TimeSlot], Error>) -> Void) {
        
        let urlString = APIEndpoints.getTimeSlots + String(employeeId)
        
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
                let timeSlots = try decoder.decode([TimeSlot].self, from: data)
//                print("time sloty: \(timeSlots)")
                completion(.success(timeSlots))
                
            } catch {
                print("klops")
                completion(.failure(error))
            }
        }.resume()
        
    }
    
    func saveAppointment(salonId: Int, employeeId: Int, customerId: Int, serviceIds: [Int], date: Date, timeStart: Time, completion: @escaping (Result<String, Error>) -> Void) {
        
        let url = URL(string: APIEndpoints.saveAppointment)!
        
        let body = AppointmentToSave(salonId: salonId, employeeId: employeeId, customerId: customerId, servicesIds: serviceIds, date: date, time: timeStart, status: AppointmentStatus.reserved.rawValue)

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let encoder = JSONEncoder.withFormattedDates
        request.httpBody = try? encoder.encode(body)
        
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
            case 201:
                print("ok")
                completion(.success("Appointment successfully saved"))
            case 400:
                print("nie ok")
                completion(.failure(NSError(domain: "", code: 400, userInfo: [NSLocalizedDescriptionKey: "Invalid input or could not save appointment"])))
            default:
                let errorMessage = HTTPURLResponse.localizedString(forStatusCode: httpResponse.statusCode)
                print("inny kod statusu: \(httpResponse.statusCode)")
                completion(.failure(NSError(domain: "", code: httpResponse.statusCode, userInfo: [NSLocalizedDescriptionKey: errorMessage])))
            }
 
                           
        }.resume()
    }
    
    
    func rescheduleAppointment(appointmentId: Int, userId: Int, userRole: String, date: Date, time: Time, completion: @escaping (Result<Void, Error>) -> Void) {

        let urlString = APIEndpoints.rescheduleAppointment + String(appointmentId)
        guard let url = URL(string: urlString) else {
            completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
            return
        }
        
        let body = RescheduleDTO(userId: userId, userRole: userRole, newDate: date, newTime: time)
        
        var request = URLRequest(url: url)
        request.httpMethod = "PATCH"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let encoder = JSONEncoder.withFormattedDates
        request.httpBody = try? encoder.encode(body)

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse {
                if 204 == httpResponse.statusCode {
                    completion(.success(()))
                } else {
                    let errorMessage = HTTPURLResponse.localizedString(forStatusCode: httpResponse.statusCode)
                    completion(.failure(NSError(domain: "", code: httpResponse.statusCode, userInfo: [NSLocalizedDescriptionKey: errorMessage])))
                }
            } else {
                completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid response"])))
            }
        }.resume()
    }
    
    func getClientByEmail(email: String, completion: @escaping (Result<Client, Error>) -> Void) {
        
        let urlString = APIEndpoints.getClientByEmail
        
        guard let url = URL(string: urlString) else {
            completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let emailDTO = EmailDTO(email: email)
        
        do {
            let jsonData = try JSONEncoder().encode(emailDTO)
            request.httpBody = jsonData
            let bodyString = String(data: jsonData, encoding: .utf8)
            print("Body: \(bodyString ?? "")")
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
                if let data = data {
                    do {
                        let client = try JSONDecoder().decode(Client.self, from: data)
                        completion(.success(client))
                    } catch {
                        completion(.failure(error))
                    }
                } else {
                    completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "No data received"])))
                }
            case 404:
                completion(.failure(NSError(domain: "", code: 404, userInfo: [NSLocalizedDescriptionKey: "Client not found"])))
            case 400:
                completion(.failure(NSError(domain: "", code: 400, userInfo: [NSLocalizedDescriptionKey: "Invalid request"])))
            default:
                print("Dupa")
                let errorDescription = HTTPURLResponse.localizedString(forStatusCode: httpResponse.statusCode)
                completion(.failure(NSError(domain: "", code: httpResponse.statusCode, userInfo: [NSLocalizedDescriptionKey: errorDescription])))
            }
        }.resume()
    }
}
