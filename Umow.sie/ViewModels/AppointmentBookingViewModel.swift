//
//  AppointmentBookingViewModel.swift
//  Umow.sie
//
//  Created by Bartosz Strzecha on 20/11/2024.
//

import Foundation

@Observable class AppointmentBookingViewModel {
    
    var employees: [Employee] = []
    var dates: [Date] = []
    var dateRange: ClosedRange<Date> = Date()...Date()
    var employeeSelection: String = "Nie wybrano"
    
    var errorMessage: String?
    
    private var appointmentService: AppointmentServiceProtocol
    
    init(appointmentService: AppointmentServiceProtocol = AppointmentService()) {
        self.appointmentService = appointmentService
    }
    
    func getEmployees(salonId: Int, serviceIds: [Int]) {
        appointmentService.getEmployees(salonId: salonId, serviceIds: serviceIds) {result in
            DispatchQueue.main.async {
                switch result {
                case .success(let employees):
                    self.employees = employees
//                    print(self.employees)
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }
    
    func getAvailabilityDates(salonId: Int, employeeId: Int) {
        appointmentService.getAvailabilityDates(salonId: salonId, employeeID: employeeId) {result in
            DispatchQueue.main.async {
                switch result {
                case .success(let dates):
                    self.dates = dates
                    self.dateRange = self.createDateRange(from: dates) ?? Date()...Date()
//                    print(self.employees)
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }
    
    
    func createDateRange(from dates: [Date]) -> ClosedRange<Date>? {
        guard let earliestDate = dates.min(),
              let latestDate = dates.max(),
              earliestDate <= latestDate else {
            return nil 
        }
        return earliestDate...latestDate
    }



}
