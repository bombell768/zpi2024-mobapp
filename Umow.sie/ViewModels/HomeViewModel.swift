//
//  HomeViewModel.swift
//  Umow.sie
//
//  Created by Bartosz Strzecha on 12/11/2024.
//

import Foundation
import Observation

@Observable class HomeViewModel {
    var fetchedSalons: [Salon] = []
    var salons: [Salon] = []
    var cities: [String] = ["Wszystkie"]
    var citySelection: String = "Wszystkie"
    var currentPhotoIndex: Int = 0
    
    var isLoading: Bool = false
    var avgCount: Int = 0
    var dataLoaded: Bool = false
    
    var errorMessage: String?
    
    private var salonService: SalonServiceProtocol
    
    init(salonService: SalonServiceProtocol = SalonService()) {
        self.salonService = salonService
    }
    

    func fetchSalons() {
        guard !dataLoaded else {
            print("Dane zostały już załadowane.")
            return
        }
        
        isLoading = true
        salonService.fetchSalons {result in
            DispatchQueue.main.async {
                switch result {
                case .success(let salons):
                    self.fetchedSalons = salons
                    self.getCities()
                    self.citySelection = self.cities[0]
                    self.fetchSalonRatings()
                    print(self.salons)

                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                    self.isLoading.toggle()
                }
            }
        }
    }
    
    func getCities() {
        let uniqueCities = Set(fetchedSalons.map { $0.city })
        let newCities = uniqueCities.filter { !cities.contains($0) }
        cities += newCities.sorted()
    }
    
    func areAllAvgsFetched() -> Bool {
        (avgCount % fetchedSalons.count) == 0
    }
    
    func getSalons() {
        if !isLoading {
            salons = fetchedSalons
        }
//        dataLoaded = true
//        print(self.salons)
    }
    
    func fetchSalonRatings() {
            
            for salon in fetchedSalons {
            
                salonService.fetchAverageSalonRating(salonId: salon.id) { result in
//                    print(salon)

                        switch result {
                        case .success(let averageRating):
//                            print("salon.id: \(salon.id)")
                            
                            if let index = self.fetchedSalons.firstIndex(where: { $0.id == salon.id }) {
                                // Modyfikujemy salon bezpośrednio w tablicy
//                                print("index: \(index)")
                                self.fetchedSalons[index].averageRating = averageRating
                            }
                            

//                            print(self.fetchedSalons)
                            self.avgCount += 1
//                            print("avgCount: \(self.avgCount)")
                            if self.areAllAvgsFetched() {
                                self.isLoading.toggle()
                            }
//                            print(salon_)

                        case .failure(let error):
                            print("Failed to fetch rating for salon \(salon.id): \(error.localizedDescription)")
                        }
                   
                }
            }

        

    }

    
}
