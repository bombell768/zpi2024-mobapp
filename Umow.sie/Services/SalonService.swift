//
//  SalonService.swift
//  Umow.sie
//
//  Created by Bartosz Strzecha on 12/11/2024.
//

import Foundation

protocol SalonServiceProtocol {
    func fetchSalons(completion: @escaping (Result<[Salon], Error>) -> Void)
}

class SalonService: SalonServiceProtocol {
    
    func fetchSalons(completion: @escaping (Result<[Salon], Error>) -> Void) {
        
        let url = URL(string: APIEndpoints.getAllSalons)!
        
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
                let salons = try JSONDecoder().decode([Salon].self, from: data)
                completion(.success(salons))
//                print(salons)
            } catch {
                completion(.failure(error))
            }
        }.resume()
        
    }
}
