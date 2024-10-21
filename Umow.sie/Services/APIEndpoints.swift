//
//  APIEndpoints.swift
//  Umow.sie
//
//  Created by Bartosz Strzecha on 20/10/2024.
//

struct APIEndpoints {
    static let baseURL = "http://192.168.1.17:8080/api/"
    static let loginClient = baseURL + "customer/login"
    static let registerClient = baseURL + "customer/register"
    static let loginEmployee = baseURL + "employee/login"
    static let registerEmployee = baseURL + "employee/register"
}
