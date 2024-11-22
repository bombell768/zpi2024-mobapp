//import UIKit
//import Foundation
//
//
//protocol SalonServiceProtocol {
//    func fetchSalons(completion: @escaping @Sendable (Result<[Salon], Error>) -> Void)
//}
//
//class SalonService: SalonServiceProtocol {
//    
//    func fetchSalons(completion: @escaping @Sendable (Result<[Salon], Error>) -> Void) {
//        
//        let url = URL(string: APIEndpoints.getAllSalons)!
//        
//        URLSession.shared.dataTask(with: url) { data, response, error in
//            
//            if let error = error {
//                completion(.failure(error))
//                return
//            }
//            
//            guard let data = data else {
//                completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "No data"])))
//                return
//            }
//            
//            do {
//                let salons = try JSONDecoder().decode([Salon].self, from: data)
//                completion(.success(salons))
//            } catch {
//                completion(.failure(error))
//            }
//        }
//        .resume()
//        
//    }
//    
//    func fetchServicesAndCategories(categoryId: Int, completion: @escaping @Sendable (Result<[ServiceCategory], Error>) -> Void) {
//        
//        let urlString = APIEndpoints.getServicesAndCategories + String(categoryId)
//        
//        let url = URL(string: urlString)!
//        
//        URLSession.shared.dataTask(with: url) { data, response, error in
//            
//            if let error = error {
//                completion(.failure(error))
//                return
//            }
//            
//            guard let data = data else {
//                completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "No data"])))
//                return
//            }
//            
//            do {
//                let root = try JSONDecoder().decode([String: [ServiceCategory]].self, from: data)
//                if let categories = root["listOfCategories"] {
//                    print(categories)
//                }
//                completion(.success(root["listOfCategories"]!))
//
//            } catch {
//                completion(.failure(error))
//            }
//        }.resume()
//        
//    }
//}
//
////SalonService().fetchSalons() { result in
////    switch result {
////    case .success(let body):
////        print("Body: \(body)")
////    case .failure(let error):
////        print(error)
////    }
////}
//
//SalonService().fetchServicesAndCategories(categoryId: 1) { result in
//    switch result {
//    case .success(let body):
//        print("Body: \(body)")
//    case .failure(let error):
//        print(error)
//    }
//}
//
//
////let json = """
////{
////  "listOfCategories": [
////    {
////      "serviceCategoryId": 1,
////      "categoryName": "Hair Styling",
////      "categoryDescription": "All hair styling services",
////      "listOfServices": [
////        {
////          "serviceID": 1,
////          "serviceName": "Haircut",
////          "serviceSpan": 2,
////          "servicePrice": 40.5,
////          "serviceDescription": "A standard haircut service",
////          "serviceCategoryModel": {
////            "serviceCategoryId": 1,
////            "categoryName": "IT Services",
////            "categoryDescription": "Category for all IT related services"
////          }
////        }
////      ]
////    }
////  ]
////}
////"""
////struct ServiceCategory: Identifiable {
////    var id: Int
////    var name: String
////    var description: String
////    var services: [Service]
////}
////
////extension ServiceCategory: Decodable {
////    enum CodingKeys: String, CodingKey {
////        case id = "serviceCategoryId"
////        case name = "categoryName"
////        case description = "categoryDescription"
////        case services = "listOfServices"
////    }
////    
//////    init(from decoder: any Decoder) throws {
//////        let container = try decoder.container(keyedBy: CodingKeys.self)
//////        let listOfCategories = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .listOfCategories)
//////        self.id = try listOfCategories.decode(Int.self, forKey: .id)
//////        self.name = try listOfCategories.decode(String.self, forKey: .name)
//////        self.description = try listOfCategories.decode(String.self, forKey: .description)
//////        self.services = try listOfCategories.decode([Service].self, forKey: .services)
//////    }
////}
////
////
////struct Service: Identifiable {
////    var id: Int
////    var name: String
////    var duration: Int
////    var price: Double
////    var description: String
////    
////    init(id: Int, name: String, duration: Int, price: Double, description: String) {
////        self.id = id
////        self.name = name
////        self.duration = duration
////        self.price = price
////        self.description = description
////    }
////}
////
////extension Service: Decodable {
////    enum CodingKeys: String, CodingKey {
////        case id = "serviceID"
////        case name = "serviceName"
////        case duration = "serviceSpan"
////        case price = "servicePrice"
////        case description = "serviceDescription"
////    }
////    
////    init(from decoder: Decoder) throws {
////        let container = try decoder.container(keyedBy: CodingKeys.self)
////        self.id = try container.decode(Int.self, forKey: .id)
////        self.name = try container.decode(String.self, forKey: .name)
////        self.duration = try container.decode(Int.self, forKey: .duration)
////        self.price = try container.decode(Double.self, forKey: .price)
////        self.description = try container.decode(String.self, forKey: .description)
////    }
////}
////
////
////let decoder = JSONDecoder()
////
////if let jsonData = json.data(using: .utf8) {
////    do {
////        let root = try decoder.decode([String: [ServiceCategory]].self, from: jsonData)
////        if let categories = root["listOfCategories"] {
////            print(categories)
////        }
////    } catch {
////        print(error)
////    }
////}
//// Tworzenie instancji z liczb
//
//struct Time {
//    var hour: Int
//    var minute: Int
//    var second: Int
//
//    // Standardowy inicjalizator
//    init(hour: Int, minute: Int, second: Int) {
//        self.hour = hour
//        self.minute = minute
//        self.second = second
//    }
//
//    // Inicjalizator z ciągu znaków w formacie "hh:mm:ss"
//    init?(from string: String) {
//        let components = string.split(separator: ":").map { Int($0) }
//        
//        // Sprawdzamy, czy mamy 3 składniki i czy udało się zamienić na liczby
//        guard components.count == 3,
//              let hour = components[0], let minute = components[1], let second = components[2],
//              (0...23).contains(hour), (0...59).contains(minute), (0...59).contains(second) else {
//            return nil // Zwracamy nil, jeśli format jest nieprawidłowy
//        }
//        
//        self.hour = hour
//        self.minute = minute
//        self.second = second
//    }
//    
//    // Formatowanie czasu jako string
//    func formatted() -> String {
//        return String(format: "%02d:%02d:%02d", hour, minute, second)
//    }
//}
//
//let time1 = Time(hour: 14, minute: 30, second: 45)
//print(time1.formatted()) // 14:30:45
//
//// Tworzenie instancji z ciągu znaków
//if let time2 = Time(from: "08:15:30") {
//    print(time2.formatted()) // 08:15:30
//} else {
//    print("Nieprawidłowy format czasu!")
//}
//
//// Obsługa nieprawidłowego wejścia
//if let time3 = Time(from: "21:51:49") {
//    print(time3.formatted())
//} else {
//    print("Nieprawidłowy format czasu!") // Wyświetli to
//}
import Foundation

let dates: [Date] = [Date()]
let weekday: Int = 5

let availableDatesForWeekday = dates.filter {
    Calendar.current.component(.weekday, from: $0) == weekday
}
