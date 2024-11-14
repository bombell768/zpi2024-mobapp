//
//  ServiceCategory.swift
//  Umow.sie
//
//  Created by Bartosz Strzecha on 05/11/2024.
//

import Foundation

struct ServiceCategory: Identifiable {
    var id: Int
    var name: String
    var description: String
    var services: [Service]
}

extension ServiceCategory: Decodable {
    enum CodingKeys: String, CodingKey {
        case id = "serviceCategoryId"
        case name = "categoryName"
        case description = "categoryDescription"
        case services = "listOfServices"
    }
    
//    init(from decoder: any Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        self.id = try listOfCategories.decode(Int.self, forKey: .id)
//        self.name = try listOfCategories.decode(String.self, forKey: .name)
//        self.description = try listOfCategories.decode(String.self, forKey: .description)
//        self.services = try listOfCategories.decode([Service].self, forKey: .services)
//    }
}

struct ServiceCategoryStore: Decodable {
    var serviceCategories: [ServiceCategory]
    
    enum CodingKeys: String, CodingKey {
        case serviceCategories = "listOfCategories"
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.serviceCategories = try container.decode([ServiceCategory].self, forKey: .serviceCategories)
    }
}


