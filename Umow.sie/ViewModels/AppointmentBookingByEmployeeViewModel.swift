//
//  AppointmentBookingByEmlpoyeeViewModel.swift
//  Umow.sie
//
//  Created by Bartosz Strzecha on 08/12/2024.
//

import Foundation

@Observable class AppointmentBookingByEmployeeViewModel {
    
    var client: Client? = nil
    var isCheckingEmail: Bool = false
    var salons: [Salon] = []
    
    var errorMessage: String?
    
    private var appointmentService: AppointmentServiceProtocol
    private var salonService: SalonServiceProtocol
        
    init(appointmentService: AppointmentServiceProtocol = AppointmentBookingService(), salonService: SalonServiceProtocol = SalonService()) {
        self.appointmentService = appointmentService
        self.salonService = salonService
    }
    
    func getClientByEmail(email: String) {
        isCheckingEmail = true
        errorMessage = nil
        
        appointmentService.getClientByEmail(email: email) {result in
            DispatchQueue.main.async {
                self.isCheckingEmail = false
                
                switch result {
                case .success(let client):
                    self.client = client
                    self.errorMessage = nil
//                    print(self.client)
                case .failure(let error):
                    self.client = nil
                    self.errorMessage = error.localizedDescription
                    print(self.errorMessage ?? "Unknown error")
                }
            }
        }
    }
    
    func fetchSalons() {
        salonService.fetchSalons {result in
            DispatchQueue.main.async {
                switch result {
                case .success(let salons):
                    self.salons = salons
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }
}
