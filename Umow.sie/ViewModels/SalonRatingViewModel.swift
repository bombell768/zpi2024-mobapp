//
//  SalonRatingViewModel.swift
//  Umow.sie
//
//  Created by Bartosz Strzecha on 03/12/2024.
//

import Foundation

@Observable class SalonRatingViewModel {
    var fetchedRatings: [RatingDTO] = []
    var employees: [Employee] = []
    var clients: [Client] = []
    var servicesForAppointments: [ServicesInAppointment] = []
    var services: [Service] = []
    var ratings: [Rating] = []
    
    var employeesIds: [Int] = []
    var clientsIds: [Int] = []
    var servicesIds: [Int] = []
    
    var areRatingsFetched: Bool = false
    var areEmployeesFetched: Bool = false
    var areClientsFetched: Bool = false
    var areServicesForRatingsFetched: Bool = false
    var areServicesFetched: Bool = false
    
    var areAllDataFetched: Bool = false
    
    var errorMessage: String?
    private var salonRatingService: SalonRatingServiceProtocol
    private var appointmentHistoryService: AppointmentHistoryServiceProtocol
    
    init(salonRatingService: SalonRatingServiceProtocol = SalonRatingService(), appointmentHistoryService: AppointmentHistoryServiceProtocol = AppointmentHistoryService()) {
        self.salonRatingService = salonRatingService
        self.appointmentHistoryService = appointmentHistoryService
    }
    
    func fetchRatingsForSalon(salonID: Int) {
        salonRatingService.getAllRatingsForSalon(salonId: salonID) {result in
                switch result {
                case .success(let ratings):
                    self.fetchedRatings = ratings
//                    print(self.ratings)
                    self.areRatingsFetched = true
                    
                    for rating in self.fetchedRatings {
                        if !self.employeesIds.contains(rating.employeeId) {
                            self.employeesIds.append(rating.employeeId)
                        }
                        
                        if !self.clientsIds.contains(rating.clientId) {
                            self.clientsIds.append(rating.clientId)
                        }
                    }
//                    print("ids klientow: \(self.clientsIds)")
                    self.getEmployees(employeesIds: self.employeesIds)
                    self.getClients(clientsIds: self.clientsIds)
                    
                    self.areAllFetched()
                    
//                    print("klienci: \(self.clients)")
                    
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                }
            
        }
    }
    
    func getEmployees(employeesIds: [Int]) {
        appointmentHistoryService.getAllEmployeesByIds(employeesIds: employeesIds) {result in
            switch result {
            case .success(let employees):
                self.employees = employees
                self.areEmployeesFetched = true
                self.areAllFetched()
//                    print(self.employees)
            case .failure(let error):
                self.errorMessage = error.localizedDescription
            }
        }
    }
    
    func getClients(clientsIds: [Int]) {
        salonRatingService.getAllClientsByIds(clientsIds: clientsIds){result in
            switch result {
            case .success(let clients):
                self.clients = clients
                self.areClientsFetched = true
                self.areAllFetched()
//                    print("klienci1: \(self.clients)")
            case .failure(let error):
                self.errorMessage = error.localizedDescription
            }
        }
    }
    
    func getServicesForRatings(salonId: Int) {
        salonRatingService.getServicesForRatings(salonId: salonId) {result in
            DispatchQueue.main.async {
                switch result {
                case .success(let servicesForAppointments):
                    self.servicesForAppointments = servicesForAppointments
                    self.areServicesForRatingsFetched = true
                    
                    for service in self.servicesForAppointments {
                        if !self.servicesIds.contains(service.serviceId) {
                            self.servicesIds.append(service.serviceId)
                        }
                    }

                      
                    self.getListOfServices(servicesIds: self.servicesIds)
                   
                    self.areAllFetched()
//                    print(self.servicesForAppointments)
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }
    
    func getListOfServices(servicesIds: [Int]) {
        print(servicesIds)
        appointmentHistoryService.getServicesByIds(servicesIds: servicesIds) {result in
                switch result {
                case .success(let services):
                    self.services = services
                    self.areServicesFetched = true
                    self.areAllFetched()
                    print(self.services)
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                }
            
        }
    }
    
    func areAllFetched() -> Void {
        if(areClientsFetched && areRatingsFetched && areServicesFetched && areEmployeesFetched && areServicesForRatingsFetched) {
            areAllDataFetched = true
        }
        
    }
    
    func getRatings() {

        if(areAllDataFetched) {
            for rating in fetchedRatings {
                var servicesForRating: [Service] = []
                
                for serviceInAppointment in servicesForAppointments {
                    if(serviceInAppointment.visitId == rating.appointmentId) {
                        
                        guard let service = services.first(where: {$0.id == serviceInAppointment.serviceId} ) else {
                            print("Usługi: \(self.services)")
                            print("idki: \(servicesIds)")
                            print("servicesForAppointment: \(servicesForAppointments)")
                            print("nie znaleziono uslugi o id: \(serviceInAppointment.serviceId)")
                            return
                        }
                        
                        
                        servicesForRating.append(service)
                    }
                }
    
                self.ratings.append(
                    Rating(id: rating.id,
                           rating: rating.rating,
                           description: rating.description,
                           employee: employees.first(where: {$0.id == rating.employeeId})!,
                           services: servicesForRating,
                           client: clients.first(where: {$0.id == rating.clientId})!
                          ))
                
            }
        }
        
        for rating in ratings {
            print(rating)
        }
     
    }
    
   
    
    
}
