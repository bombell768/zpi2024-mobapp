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
    var employeeSelection: Employee = Employee()
    var dateSelection: Date = Date()
    var selectedTimeSlot: TimeSlot = TimeSlot()
    var currentEmployee: Employee?
    var openingHours: [OpeningHours] = []
    var employeeTimeSlots: [TimeSlot] = []
    var occupiedTimeSlots: [TimeSlot] = []
    
    var errorMessage: String?
    var isLoadingOpeningHours: Bool = false
    var isLoadingDates: Bool = false
    var isLoadingTimeSlots: Bool = false
    
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
        isLoadingDates = true
        appointmentService.getAvailabilityDates(salonId: salonId, employeeID: employeeId) {result in
            DispatchQueue.main.async {
                switch result {
                case .success(let dates):
                    self.dates = dates
//                    print(dates)
                    self.dateRange = self.createDateRange(from: dates) ?? Date()...Date()
                    self.dateSelection = self.dates.first!
                    self.isLoadingDates = false
//                    print(self.employees)
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }
    
    func getOpeningHours(salonId: Int) {
        isLoadingOpeningHours = true
        appointmentService.getOpeningHours(salonId: salonId) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let openingHours):
                    self.openingHours = openingHours
                    self.isLoadingOpeningHours = false
//                    print("Opening hours:", openingHours)
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }
    
    func getTimeSlots(employeeId: Int) {
        isLoadingTimeSlots = true
        appointmentService.getTimeSlots(employeeId: employeeId) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let timeSlots):
                    self.occupiedTimeSlots = timeSlots
                    self.isLoadingTimeSlots = false
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }
    
    func saveAppointment(salonId: Int, employeeId: Int, customerId: Int, serviceIds: [Int], date: Date, timeStart: Time) {
        print(date)
        appointmentService.saveAppointment(salonId: salonId, employeeId: employeeId, customerId: customerId, serviceIds: serviceIds, date: date, timeStart: timeStart) { result in
            DispatchQueue.main.async {
                switch result  {
                case .success(let response):
                    print(response)
                    print("Wizyta zapisana pomyślnie.")
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
    
    func generateTimeSlots(for employee: Employee) -> Void {
        var timeSlots: [TimeSlot] = []
        
//        print("opening hours: \(openingHours)")
        for openingHour in openingHours {
//            print("opening hour: \(openingHour)")
            let weekday = openingHour.calendarWeekday
            let openingTime = openingHour.openingHour
            let closingTime = openingHour.closingHour
            
//            print("daty \(dates)")
            let availableDatesForWeekday = dates.filter {
                Calendar.current.component(.weekday, from: $0) == weekday
            }
            
//            print(availableDatesForWeekday)
            
            for date in availableDatesForWeekday {
                var currentTime = openingTime
                
                while currentTime < closingTime {
                    if let slotStartDate = combine(date: date, time: currentTime) {
                        let timeSlot = TimeSlot(date: slotStartDate, time: currentTime, employeeId: employee.id)
                        timeSlots.append(timeSlot)
                    }
                    
                    currentTime = currentTime.adding(minutes: 15)
                }
            }
        }
        for timeSlot in occupiedTimeSlots {
            print("occupied: \(timeSlot)")
        }
        timeSlots = timeSlots.filter { timeSlot in
            !occupiedTimeSlots.contains(timeSlot)}
        
        print("employee: \(timeSlots[0].employeeId)")
        for timeSlot in timeSlots {
            print("time slot: \(timeSlot.time),  date: \(timeSlot.date)")
        }
        
        employeeTimeSlots = timeSlots
    }

    private func combine(date: Date, time: Time) -> Date? {
        var calendar = Calendar.current
        calendar.timeZone = TimeZone.current
        
        let components = DateComponents(
            year: calendar.component(.year, from: date),
            month: calendar.component(.month, from: date),
            day: calendar.component(.day, from: date),
            hour: time.hour,
            minute: time.minute,
            second: time.second
        )
        
        return calendar.date(from: components)
    }

}
