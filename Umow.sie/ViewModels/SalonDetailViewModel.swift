//
//  SalonDetailViewModel.swift
//  Umow.sie
//
//  Created by Bartosz Strzecha on 13/11/2024.
//

import Foundation

@Observable class SalonDetailViewModel {
    
    var serviceCategories: [ServiceCategory] = []
    var errorMessage: String?
    
    private var salonService: SalonServiceProtocol
    
    init(salonService: SalonServiceProtocol = SalonService()) {
        self.salonService = salonService
    }
    

    func fetchServicesAndCategories(salonId: Int) {
        salonService.fetchServicesAndCategories(salonId: salonId) {result in
            DispatchQueue.main.async {
                switch result {
                case .success(let categories):
                    self.serviceCategories = categories
//                        print(self.serviceCategories)
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }
    
    
}
