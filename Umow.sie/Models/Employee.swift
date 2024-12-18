//
//  Employee.swift
//  Umow.sie
//
//  Created by Bartosz Strzecha on 15/11/2024.
//

import Foundation

struct Employee: Codable, Identifiable, Hashable, Equatable {
    let id: Int
    var name: String
    var surname: String
    var phoneNumber: String
    var email: String
    var password: String
    let birthDate: Date
    let employmentDate: Date
    var monthlySalary: Double
    var city: String
    var street: String
    var buildingNumber: String
    var apartmentNumber: String
    var postalCode: String
    
    init() {
        id = 1
        name = "Nie wybrano"
        surname = ""
        phoneNumber = ""
        email = ""
        password = ""
        birthDate = .distantPast
        employmentDate = .distantPast
        monthlySalary = 0.0
        city = ""
        street = ""
        buildingNumber = ""
        apartmentNumber = ""
        postalCode = ""
    }
    
    enum CodingKeys: String, CodingKey {
        case id = "employeeID"
        case name = "employeeName"
        case surname = "employeeSurname"
        case phoneNumber = "employeeDialNumber"
        case password = "encryptedEmployeePassword"
        case email = "employeeEmail"
        case birthDate = "employeeBirthdayDate"
        case employmentDate = "employeeEmploymentDate"
        case monthlySalary = "employeeMonthlyPay"
        case city = "employeeCity"
        case street = "employeeStreet"
        case buildingNumber = "employeeBuildingNumber"
        case apartmentNumber = "employeeApartmentNumber"
        case postalCode = "employeePostalCode"
    }
}
