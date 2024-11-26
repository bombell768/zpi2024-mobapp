//
//  APIEndpoints.swift
//  Umow.sie
//
//  Created by Bartosz Strzecha on 20/10/2024.
//

struct APIEndpoints {
    static let baseURL2 = "http://192.168.1.11:8080/api/"
    
    static let baseURL = "https://zpi2024-be.onrender.com/api/"
    
    static let loginClient = baseURL + "customer/login"
    static let registerClient = baseURL + "customer/register"
    static let loginEmployee = baseURL + "employee/login"
    static let registerEmployee = baseURL + "employee/register"
    static let getAllSalons = baseURL + "crud/salons"
    static let getServicesAndCategories = baseURL + "crud/appointment-making/services-and-categories/"
    static let getEmployees = baseURL + "crud/appointment-making/employees"
    static let getAvailabilityDates = baseURL + "crud/appointment-making/availability-dates/"
    static let getOpeningHours = baseURL + "crud/appointment-making/opening-hours/"
    static let getTimeSlots = baseURL + "crud/appointment-making/time-slots/"
    static let saveAppointment = baseURL + "crud/appointment-making/save-visit"
}
