//
//  AppointmentsHistoryViewModel.swift
//  Umow.sie
//
//  Created by Bartosz Strzecha on 29/11/2024.
//

import Foundation

struct AppointmentDetails {
    let serviceNames: [String]
    let salonName: String
    let salonAddress: String
    let employeeName: String
    let date: Date
    let time: Time
}


@Observable class AppointmentsHistoryViewModel {
    var employees: [Employee] = []
    var salons: [Salon] = []
    var fetchedAppointments: [AppointmentDTO] = []
    var servicesForAppointments: [ServicesInAppointment] = []
    var services: [Service] = []
    
    var employeesIds: [Int] = []
    var servicesIds: [Int] = []
    
    var areAppointmentsFetched: Bool = false
    var areServicesInAppoitmentFetched: Bool = false
    var areSalonsFetched: Bool = false
    var areEmployeesFetched: Bool = false
    var areAllDataFetched: Bool = false
    var areServicesFetched: Bool = false
    
    var appointments: [Appointment] = []
    
    var filteredAppointments: [Appointment] = []
    var selectedStatus: AppointmentStatus? = .reserved
    
    var errorMessage: String?
    private var appointmentHistoryService: AppointmentHistoryServiceProtocol
    private var salonService: SalonServiceProtocol
    
    init(appointmentService: AppointmentHistoryServiceProtocol = AppointmentHistoryService(), salonService: SalonServiceProtocol = SalonService()) {
        self.appointmentHistoryService = appointmentService
        self.salonService = salonService
    }
    
    func getEmployees(employeesIds: [Int]) {
        appointmentHistoryService.getAllEmployeesByIds(employeesIds: employeesIds) {result in
            
                switch result {
                case .success(let employees):
                    self.employees = employees
                    self.areEmployeesFetched = true
                    self.areAllFetched()
                    print("1 \(self.areAllDataFetched)")
//                    print(self.employees)
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                }
            
        }
    }
    
    func fetchSalons() {
        salonService.fetchSalons {result in
            DispatchQueue.main.async {
                switch result {
                case .success(let salons):
                    self.salons = salons
                    self.areSalonsFetched = true
                    self.areAllFetched()
                    print("2 \(self.areAllDataFetched)")
//                    print(self.salons)
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }
    
    func fetchAppointments(customerId: Int) {
        appointmentHistoryService.getAllAppointmentsForCustomer(customerId: customerId) {result in
            DispatchQueue.main.async {
                switch result {
                case .success(let appointments):
                    self.fetchedAppointments = appointments
                    
                    self.areAppointmentsFetched = true
                    
                    for appointment in self.fetchedAppointments {
                        if !self.employeesIds.contains(appointment.employeeId) {
                            self.employeesIds.append(appointment.employeeId)
                        }
                    }

                    
                    self.getEmployees(employeesIds: self.employeesIds)
                    
                    self.areAllFetched()
                    
                    print("3 \(self.areAllDataFetched)")
                    
//                    print(self.appointments)
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }
    
    func getServicesForAppointments(customerId: Int) {
        appointmentHistoryService.getServicesInAppointments(customerId: customerId) {result in
            DispatchQueue.main.async {
                switch result {
                case .success(let servicesForAppointments):
                    self.servicesForAppointments = servicesForAppointments
                    
                    self.areServicesInAppoitmentFetched = true
                    
                    for service in self.servicesForAppointments {
                        if !self.servicesIds.contains(service.serviceId) {
                            self.servicesIds.append(service.serviceId)
                        }
                    }

                      
                    self.getListOfServices(servicesIds: self.servicesIds)
                   
                    self.areAllFetched()
                    
                    print("4 \(self.areAllDataFetched)")
                    
//                    print(self.servicesForAppointments)
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }
    
    func getListOfServices(servicesIds: [Int]) {
        appointmentHistoryService.getServicesByIds(servicesIds: servicesIds) {result in
            
                switch result {
                case .success(let services):
                    self.services = services
                    self.areServicesFetched = true
                    self.areAllFetched()
                    
                    print("5 \(self.areAllDataFetched)")
                    
//                    print(self.services)
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                }
            
        }
    }
    
    func filterAppointments() {
       if let status = selectedStatus {
           self.filteredAppointments = appointments.filter { $0.status == status }
       } else {
           self.filteredAppointments = appointments
       }
   }
    
    func areAllFetched() -> Void {
        if(areAppointmentsFetched && areServicesInAppoitmentFetched && areSalonsFetched && areEmployeesFetched && areServicesFetched) {
            areAllDataFetched = true
        }
        
    }
    
    
    func getAppointments() {
        
        for s in servicesForAppointments {
            print(s)
        }
        
        if(areAllDataFetched) {
            for appointment in fetchedAppointments {
                var servicesForAppointment: [Service] = []
                
                for serviceInAppointment in servicesForAppointments {
                    if(serviceInAppointment.visitId == appointment.id) {
                        
                        guard let service = services.first(where: {$0.id == serviceInAppointment.serviceId} ) else {
                            print("Usługi: \(self.services)")
                            print("idki: \(servicesIds)")
                            print("servicesForAppointment: \(servicesForAppointments)")
                            print("nie znaleziono uslugi o id: \(serviceInAppointment.serviceId)")
                            return
                        }
                        
                        
                        servicesForAppointment.append(service)
                    }
                }
    
                self.appointments.append(
                    Appointment(
                        id: appointment.id,
                        date: appointment.date,
                        time: appointment.time,
                        status: appointment.status,
                        salon: salons.first(where: {$0.id == appointment.salonId})!,
                        employee: employees.first(where: {$0.id == appointment.employeeId})!,
                        services: servicesForAppointment
                    ))
                
            }
        }
        
//        for appointment in appointments {
//            print(appointment)
//        }
     
        filterAppointments()
    }
}
