//
//  SalonRatingService.swift
//  Umow.sie
//
//  Created by Bartosz Strzecha on 03/12/2024.
//

import Foundation

protocol SalonRatingServiceProtocol {
    func getAllRatingsForSalon(salonId: Int, completion: @escaping (Result<[RatingDTO], Error>) -> Void)
    func getAllClientsByIds(clientsIds: [Int], completion: @escaping (Result<[Client], Error>) -> Void)
    func getServicesForRatings(salonId: Int, completion: @escaping (Result<[ServicesInAppointment], Error>) -> Void)
    func addRating(ratingValue: Double, description: String, employeeId: Int, appointmentId: Int, completion: @escaping (Result<RatingBodyDTO, Error>) -> Void)
}

class SalonRatingService: SalonRatingServiceProtocol {
    
    func getAllRatingsForSalon(salonId: Int, completion: @escaping (Result<[RatingDTO], Error>) -> Void) {
        
        let urlString = APIEndpoints.getAllRatingsForSalon + String(salonId)
        
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
                let ratings = try JSONDecoder().decode([RatingDTO].self, from: data)
//                print(ratings)
                completion(.success(ratings))
                
            } catch {
                completion(.failure(error))
            }
                           
        }.resume()
    }
    
    func getAllClientsByIds(clientsIds: [Int], completion: @escaping (Result<[Client], Error>) -> Void) {
        
        let urlString = APIEndpoints.getAllClientsByIds
        
        guard let url = URL(string: urlString) else {
            completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
            return
        }
        
        let body = clientsIds
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONEncoder().encode(body)
        
//        if let httpBody = request.httpBody {
//            if let bodyString = String(data: httpBody, encoding: .utf8) {
//                print("Body zapytania (id Klientow):")
//                print(bodyString)
//            } else {
//                print("Nie udało się zdekodować danych body.")
//            }
//        } else {
//            print("Zapytanie nie zawiera danych body.")
//        }
        
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
                let clients = try decoder.decode([Client].self, from: data)
//                for client in clients {
//                    print(client)
//                }

                completion(.success(clients))
                
            } catch {
                print("Nie udało się zdekodować danych.")
                completion(.failure(error))
            }
            
        }.resume()
    }
    
    
    func getServicesForRatings(salonId: Int, completion: @escaping (Result<[ServicesInAppointment], Error>) -> Void) {
        
        let urlString = APIEndpoints.getServicesforRatings + String(salonId)
        
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
    
    func addRating(ratingValue: Double, description: String, employeeId: Int, appointmentId: Int, completion: @escaping (Result<RatingBodyDTO, Error>) -> Void) {
        
        let urlString =  APIEndpoints.postRating
        
        guard let url = URL(string: urlString) else {
            completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
            return
        }
        
        let body = RatingBodyDTO(id: 0, rating: ratingValue, description: description, employeeId: employeeId, appointmentId: appointmentId)

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

            guard let data = data else {
                completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "No data"])))
                return
            }
            
            
            do {
                let rating = try JSONDecoder().decode(RatingBodyDTO.self, from: data)
                print("odpowiedź: \(rating)")
                completion(.success(rating))
                
            } catch {
                completion(.failure(error))
            }
 
                           
        }.resume()
    }
}
