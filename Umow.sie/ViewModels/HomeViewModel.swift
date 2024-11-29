//
//  HomeViewModel.swift
//  Umow.sie
//
//  Created by Bartosz Strzecha on 12/11/2024.
//

import Foundation
import Observation

@Observable class HomeViewModel {
    var salons: [Salon] = []
    var cities: [String] = ["Wszystkie"]
    var citySelection: String = "Wszystkie"
    var currentPhotoIndex: Int = 0
    
    var errorMessage: String?
    
    private var salonService: SalonServiceProtocol
    
    init(salonService: SalonServiceProtocol = SalonService()) {
        self.salonService = salonService
    }
    

    func fetchSalons() {
        salonService.fetchSalons {result in
            DispatchQueue.main.async {
                switch result {
                case .success(let salons):
                    self.salons = salons
                    self.getCities()
                    self.citySelection = self.cities[0]
                    self.fetchSalonRatings()
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }
    
    func getCities() {
        let uniqueCities = Set(salons.map { $0.city })
        let newCities = uniqueCities.filter { !cities.contains($0) }
        cities += newCities.sorted()
    }
    
    func fetchSalonRatings() {
        let dispatchGroup = DispatchGroup()
        
        for (index, salon) in salons.enumerated() {
            dispatchGroup.enter()
            
            salonService.fetchAverageSalonRating(salonId: salon.id) {result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let averageRating):
                        self.salons[index].averageRating = averageRating
                    case .failure(let error):
                        print("Failed to fetch rating for salon \(salon.id): \(error.localizedDescription)")
                    }
                    dispatchGroup.leave()
                }
            }
        }
        
        dispatchGroup.notify(queue: .main) {
            print("All salon ratings fetched")
        }
    }

    
}
