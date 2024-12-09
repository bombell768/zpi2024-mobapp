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
    var showAlert: Bool = false
    var isAppointmentBooked: Bool = false
    var isAppointmentRescheduled: Bool = false
    var isAppointmentSaved: Bool = false
    var showChangeDateViewAlert: Bool = false
    var backFromAppointmentRescheduling: Bool = false
    
    var appointment: Appointment?
    
    var client: Client? = nil
    var isCheckingEmail: Bool = false
    var salons: [Salon] = []
    
    var errorMessage: String?
    var isLoadingOpeningHours: Bool = false
    var isLoadingDates: Bool = false
    var isLoadingTimeSlots: Bool = false
    
    private var appointmentService: AppointmentServiceProtocol
    private var salonService: SalonServiceProtocol
    
    init(appointmentService: AppointmentServiceProtocol = AppointmentBookingService(), salonService: SalonServiceProtocol = SalonService()) {
        self.appointmentService = appointmentService
        self.salonService = salonService
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
                    self.isAppointmentSaved = true
                    self.showChangeDateViewAlert = true
                    print(response)
                    print("Wizyta zapisana pomyślnie.")
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }
    
    func rescheduleAppointment(appointmentId: Int, userId: Int, userRole: String, newDate: Date, newTime: Time) {
        appointmentService.rescheduleAppointment(appointmentId: appointmentId, userId: userId, userRole: userRole, date: newDate, time: newTime) { result in
            DispatchQueue.main.async {
                switch result  {
                case .success:
                    self.showChangeDateViewAlert = true
                    self.isAppointmentRescheduled = true
                    print("Wizyta przeniesiona pomyślnie.")
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
    
//    func generateTimeSlots(for employee: Employee, selectedServices: [Service]) -> Void {
//        var timeSlots: [TimeSlot] = []
//        
//        let totalDuration = selectedServices.reduce(0) { $0 + $1.duration } * 15
//        print("total duration: \(totalDuration)")
//        
////        print("opening hours: \(openingHours)")
//        for openingHour in openingHours {
////            print("opening hour: \(openingHour)")
//            let weekday = openingHour.calendarWeekday
//            let openingTime = openingHour.openingHour
//            let closingTime = openingHour.closingHour
//            
////            print("weekday \(weekday), openingTime \(openingTime), closingTime \(closingTime)")
//            
////            print("daty \(dates)")
//            let availableDatesForWeekday = dates.filter {
//                Calendar.current.component(.weekday, from: $0) == weekday
//            }
//            
////            print("weekday \(weekday), availableDatesForWeekday \(availableDatesForWeekday)")
//            
//            for date in availableDatesForWeekday {
//                var currentTime = openingTime
////                print("currentTime \(currentTime)")
//                
//                while currentTime < closingTime {
////                    print("currentTime \(currentTime)")
//                    guard let slotStartDate = combine(date: date, time: currentTime) else {
//                        break
//                    }
//                    
//                    let slotEndTime = currentTime.adding(minutes: totalDuration)
//                    
//                    if slotEndTime <= closingTime {
//                        let timeSlot = TimeSlot(date: slotStartDate, time: currentTime, employeeId: employee.id)
////                        print("timeSlot for weekday \(weekday): \(timeSlot)")
//                        if !occupiedTimeSlots.contains(where: { occupiedSlot in
//                            (occupiedSlot.date == timeSlot.date) &&
//                            (occupiedSlot.time >= timeSlot.time && occupiedSlot.time < slotEndTime)
//                        }) {
//                            timeSlots.append(timeSlot)
//                        }
//                    }
//                    
//                    currentTime = currentTime.adding(minutes: 15)
//                }
//            }
//        }
//        for timeSlot in occupiedTimeSlots {
//            print("occupied: \(timeSlot)")
//        }
//        
//        timeSlots = timeSlots.filter { timeSlot in
//            !occupiedTimeSlots.contains(timeSlot)}
//        
////        print("employee: \(timeSlots[0].employeeId)")
////        for timeSlot in timeSlots {
////            print("time slot: \(timeSlot.time),  date: \(timeSlot.date)")
////        }
//        
//        employeeTimeSlots = timeSlots
//    }
    
    func generateTimeSlots(for employee: Employee, selectedServices: [Service]) -> Void {
        var timeSlots: [TimeSlot] = []
        
        let totalDuration = selectedServices.reduce(0) { $0 + $1.duration } * 15
        print("total duration: \(totalDuration)")
        
//        print("opening hours: \(openingHours)")
        for openingHour in openingHours {
//            print("opening hour: \(openingHour)")
            let weekday = openingHour.calendarWeekday
            let openingTime = openingHour.openingHour
            let closingTime = openingHour.closingHour
            let lastPossibleTime = closingTime.subtracting(minutes: totalDuration)
//            print("last possible time: \(closingTime.subtracting(minutes: totalDuration))")
//            print("weekday \(weekday), openingTime \(openingTime), closingTime \(closingTime)")
            
//            print("daty \(dates)")
            let availableDatesForWeekday = dates.filter {
                Calendar.current.component(.weekday, from: $0) == weekday
            }
            
//            print("weekday \(weekday), availableDatesForWeekday \(availableDatesForWeekday)")
            
            for date in availableDatesForWeekday {
                var currentTime = openingTime
//                print("currentTime \(currentTime)")
                
                while currentTime <= lastPossibleTime {
                    let startTimeSlot = TimeSlot(date: date, time: currentTime, employeeId: employee.id)
                    let endTimeSlot = TimeSlot(date: date, time: currentTime.adding(minutes: totalDuration - 15), employeeId: employee.id)
                    var startTime = startTimeSlot.time
                    let endTime = endTimeSlot.time
                    var isCurrentTimePossible = true
                    
                    
                    print("startTime \(startTimeSlot), endTime \(endTimeSlot))")
                    while startTime <= endTime {
                        if occupiedTimeSlots.contains(where: { occupiedSlot in
                            (occupiedSlot.date == startTimeSlot.date) &&
                            (occupiedSlot.time == startTime)
                        }) {
                            isCurrentTimePossible = false
                        }
                        startTime = startTime.adding(minutes: 15)
                    }
                    print("isCurrentTimePossible \(isCurrentTimePossible)")
                    
                    if isCurrentTimePossible {
                        timeSlots.append(startTimeSlot)
                    }
                    
                    currentTime = currentTime.adding(minutes: 15)
                }
            }
        }
//        for timeSlot in occupiedTimeSlots {
//            print("occupied: \(timeSlot)")
//        }
        
//        timeSlots = timeSlots.filter { timeSlot in
//            !occupiedTimeSlots.contains(timeSlot)}
        
//        print("employee: \(timeSlots[0].employeeId)")
//        for timeSlot in timeSlots {
//            print("time slot: \(timeSlot.time),  date: \(timeSlot.date)")
//        }
        
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
