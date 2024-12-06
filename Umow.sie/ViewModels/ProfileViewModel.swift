//
//  ProfileViewModel.swift
//  Umow.sie
//
//  Created by Bartosz Strzecha on 06/12/2024.
//

import Foundation

@Observable class ProfileViewModel {
    
    var numberOfSeals: Int = 0
    var client: Client = Client()
    
    var errorMessage: String?
    private var profileService: ProfileServiceProtocol
    
    init(profileService: ProfileServiceProtocol = ProfileService()) {
        self.profileService = profileService
    }
    
    func getNumberOfSeals(clientId: Int) {
        profileService.getNumberOfCompletedAppointments(customerId: clientId) { result in
            DispatchQueue.main.async {
                switch result  {
                case .success(let numberOfSeals):
                    self.numberOfSeals = numberOfSeals % 10
                    print("Liczba pieczątek: \(self.numberOfSeals)")
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                    print(self.errorMessage ?? "Unknown error")
                }
            }
        }
    }
    
    func getClientById(clientId: Int) {
        profileService.getClientById(customerId: clientId) { result in
            DispatchQueue.main.async {
                switch result  {
                case .success(let client):
                    self.client = client
                    print("Klient w viewModel: \(self.client)")
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                    print(self.errorMessage ?? "Unknown error")
                }
            }
        }
    }
}
