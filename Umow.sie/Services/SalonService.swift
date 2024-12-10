//
//  SalonService.swift
//  Umow.sie
//
//  Created by Bartosz Strzecha on 12/11/2024.
//

import Foundation

protocol SalonServiceProtocol {
    func fetchSalons(completion: @escaping (Result<[Salon], Error>) -> Void)
    func fetchServicesAndCategories(salonId: Int, completion: @escaping (Result<[ServiceCategory], Error>) -> Void)
    func fetchAverageSalonRating(salonId: Int, completion: @escaping (Result<Double, Error>) -> Void)
}

class SalonService: SalonServiceProtocol {
    
    func fetchSalons(completion: @escaping (Result<[Salon], Error>) -> Void) {
        
        let url = URL(string: APIEndpoints.getAllSalons)!
        
        var request = URLRequest(url: url)
        if let token = getToken() {
            request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        } else {
            completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "No token available"])))
            return
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
                let salons = try JSONDecoder().decode([Salon].self, from: data)
                completion(.success(salons))
//                print(salons)
            } catch {
                completion(.failure(error))
            }
        }.resume()
        
    }
    
    func fetchServicesAndCategories(salonId: Int, completion: @escaping (Result<[ServiceCategory], Error>) -> Void) {
        
        let urlString = APIEndpoints.getServicesAndCategories + String(salonId)
        
        let url = URL(string: urlString)!
        
        var request = URLRequest(url: url)
        if let token = getToken() {
            request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        } else {
            completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "No token available"])))
            return
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
                let root = try JSONDecoder().decode([String: [ServiceCategory]].self, from: data)
//                if let categories = root["listOfCategories"] {
//                    print(categories)
//                }
                completion(.success(root["listOfCategories"]!))

            } catch {
                completion(.failure(error))
            }
        }.resume()
        
    }
    
    func fetchAverageSalonRating(salonId: Int, completion: @escaping (Result<Double, Error>) -> Void) {
        
        let urlString = APIEndpoints.getAvgSalonRating + String(salonId)
        
        guard let url = URL(string: urlString) else {
            completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
            return
        }
        
        var request = URLRequest(url: url)
        if let token = getToken() {
            request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        } else {
            completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "No token available"])))
            return
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
                let decodedResponse = try JSONDecoder().decode(SalonRatingResponse.self, from: data)
                print(decodedResponse.averageRating)
                completion(.success(decodedResponse.averageRating))
            } catch {
                completion(.failure(error))
            }
        }.resume()
        
    }
   
    private func getToken() -> String? {
        return UserDefaults.standard.string(forKey: "authToken")
    }
}
