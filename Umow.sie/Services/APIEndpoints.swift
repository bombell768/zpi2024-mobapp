//
//  APIEndpoints.swift
//  Umow.sie
//
//  Created by Bartosz Strzecha on 20/10/2024.
//

struct APIEndpoints {
    static let baseURL = "http://192.168.1.11:8080/api/"
    
    static let baseURL2 = "https://zpi2024-be.onrender.com/api/"
    
    static let loginClient = baseURL + "auth/customer/login"
    static let registerClient = baseURL + "auth/customer/register"
    static let loginEmployee = baseURL + "auth/employee/login"
    static let registerEmployee = baseURL + "auth/employee/register"
    static let getAllSalons = baseURL + "crud/salons"
    static let getServicesAndCategories = baseURL + "crud/appointment-making/services-and-categories/"
    static let getEmployees = baseURL + "crud/appointment-making/employees"
    static let getAvailabilityDates = baseURL + "crud/appointment-making/availability-dates/"
    static let getOpeningHours = baseURL + "crud/appointment-making/opening-hours/"
    static let getTimeSlots = baseURL + "crud/appointment-making/time-slots/"
    static let saveAppointment = baseURL + "crud/appointment-making/save-visit"
    static let getAvgSalonRating = baseURL + "crud/rating/avgForSalon/"
    static let getAllEmployeesByIds = baseURL + "crud/employee/getAllByIds"
    static let getAllAppointmentsForCustomer = baseURL + "crud/visit/withIds/forCustomer/"
    static let getServicesInAppointments = baseURL + "crud/service-visit/forCustomer/"
    static let getAllServicesByIds = baseURL + "crud/service/getAllById"
    static let getAllRatingsForSalon = baseURL + "crud/rating/allForSalonWithCustomer/"
    static let getAllRatingsForClient = baseURL + "crud/rating/getAllByCustomerId/"
    static let getAllClientsByIds = baseURL + "crud/customer/getAllById"
    static let getServicesforRatings = baseURL + "crud/service-visit/forSalon/"
    static let postRating = baseURL + "crud/rating"
    static let cancelAppointment = baseURL + "crud/appointment-making/cancel-customer/"
    static let rescheduleAppointment = baseURL + "crud/appointment-making/reschedule-visit/"
    static let getNumberOfCompletedAppointments = baseURL + "crud/visit/doneForCustomer/"
    static let getClientById = baseURL + "crud/customer/"
    static let updateClient = baseURL + "crud/customer"
}
