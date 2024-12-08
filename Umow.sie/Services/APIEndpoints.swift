//
//  APIEndpoints.swift
//  Umow.sie
//
//  Created by Bartosz Strzecha on 20/10/2024.
//

struct APIEndpoints {
    static let baseURL = "http://192.168.1.11:8080/api/"
    
    static let baseURL1 = "https://backend-zpi.purplesand-ca238c0b.polandcentral.azurecontainerapps.io/api/"
    
    
    // auth (client)
    static let loginClient = baseURL + "auth/customer/login"
    static let registerClient = baseURL + "auth/customer/register"
    
    // auth (employee)
    static let loginEmployee = baseURL + "auth/employee/login"
    static let registerEmployee = baseURL + "auth/employee/register"
    
    // salon (both employee and client)
    static let getAllSalons = baseURL + "crud/salons"
    static let getServicesAndCategories = baseURL + "crud/appointment-making/services-and-categories/"
    static let getAvgSalonRating = baseURL + "crud/rating/avgForSalon/" // only client
    
    //appointment booking (both)
    static let getEmployees = baseURL + "crud/appointment-making/employees"
    static let getAvailabilityDates = baseURL + "crud/appointment-making/availability-dates/"
    static let getOpeningHours = baseURL + "crud/appointment-making/opening-hours/"
    static let getTimeSlots = baseURL + "crud/appointment-making/time-slots/"
    static let saveAppointment = baseURL + "crud/appointment-making/save-visit"
    static let rescheduleAppointment = baseURL + "crud/appointment-making/reschedule-visit/"
    static let getClientByEmail = baseURL + "crud/customer/find-by-email"   //only employee
    
    // appointment history (both)
    static let getAllEmployeesByIds = baseURL + "crud/employee/getAllByIds"
    static let getAllClientsByIds = baseURL + "crud/customer/getAllById"
    static let getAllAppointmentsForCustomer = baseURL + "crud/visit/withIds/forCustomer/"  //only client
    static let getAllAppointmentsForEmployee = baseURL + "crud/visit/withIds/forEmployee/"  //only employee
    static let getServicesInAppointments = baseURL + "crud/service-visit/forCustomer/"      //only client
    static let getServicesInAppointmentsEmployee = baseURL + "crud/service-visit/forEmployee/"  //only employee
    static let getAllServicesByIds = baseURL + "crud/service/getAllById"
    static let getAllRatingsForClient = baseURL + "crud/rating/getAllByCustomerId/" //only client
    static let getAllRatingsForEmployee = baseURL + "crud/rating/allForEmployee/"   //only employee
    static let postRating = baseURL + "crud/rating"                                 //only client
    static let cancelAppointment = baseURL + "crud/appointment-making/cancel-customer/"
    
    // salon rating (only client)
    static let getAllRatingsForSalon = baseURL + "crud/rating/allForSalonWithCustomer/"
    static let getServicesforRatings = baseURL + "crud/service-visit/forSalon/"
   
    // profile
    static let getNumberOfCompletedAppointments = baseURL + "crud/visit/doneForCustomer/"   //only client
    static let getClientById = baseURL + "crud/customer/"   //only client
    static let updateClient = baseURL + "crud/customer"     //only client
    static let getEmployeeById = baseURL + "crud/employee/" //only employee
    
}
