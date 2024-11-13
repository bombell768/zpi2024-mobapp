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
//                    print(self.salons)
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }
    
    
}
