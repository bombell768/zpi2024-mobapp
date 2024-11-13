import UIKit
import Foundation

protocol SalonServiceProtocol {
    func fetchSalons(completion: @escaping @Sendable (Result<[Salon], Error>) -> Void)
}

class SalonService: SalonServiceProtocol {
    
    func fetchSalons(completion: @escaping @Sendable (Result<[Salon], Error>) -> Void) {
        
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
            } catch {
                completion(.failure(error))
            }
        }
        .resume()
        
    }
}

SalonService().fetchSalons() { result in
    switch result {
    case .success(let body):
        print("Body: \(body)")
    case .failure(let error):
        print(error)
    }
}
