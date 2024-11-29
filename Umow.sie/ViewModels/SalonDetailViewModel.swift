//
//  SalonDetailViewModel.swift
//  Umow.sie
//
//  Created by Bartosz Strzecha on 13/11/2024.
//

import Foundation

@Observable class SalonDetailViewModel {
    
    var serviceCategories: [ServiceCategory] = []
    var selectedServices: [Service] = []
    
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
    
    func toggleServiceSelection(_ service: Service) {
        if selectedServices.contains(where: { $0.id == service.id }) {
            selectedServices.removeAll(where: { $0.id == service.id })
        } else if selectedServices.count < 3 {
            selectedServices.append(service)
        }
    }
    
    func isServiceSelected(_ service: Service) -> Bool {
        selectedServices.contains(where: { $0.id == service.id })
    }
    
    func getServicesIndices() -> [Int] {
        var servicesIndices: [Int] = []
        for service in selectedServices {
            servicesIndices.append(service.id)
        }
        print("servicesIndices: \(servicesIndices)")
        return servicesIndices
    }
    
    func getTotalPrice() -> Double {
        return selectedServices.reduce(0) { $0 + $1.price }
    }
    
    func getTotalDuration() -> String {
        let totalMinutes = selectedServices.reduce(0) { $0 + $1.duration } * 15

        let hours = totalMinutes / 60
        let minutes = totalMinutes % 60

        if hours > 0 {
            return "\(hours) h \(minutes) min"
        } else {
            return "\(minutes) min"
        }
    }
}
