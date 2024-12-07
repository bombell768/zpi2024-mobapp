//
//  EntryView.swift
//  Umow.sie
//
//  Created by Bartosz Strzecha on 05/12/2024.
//

import SwiftUI

struct EntryView: View {
    @AppStorage("isClientLoggedIn") private var isClientLoggedIn: Bool = false
    @AppStorage("isEmployeeLoggedIn") private var isEmployeeLoggedIn: Bool = false
    @AppStorage("authToken") private var authToken: String?
    
    var body: some View {
        
        Group {
            if isClientLoggedIn {
                MainView()
            }
            else if isEmployeeLoggedIn {
                EmployeeMainView()
            }
            else {
                LoginView()
            }
        }

    }
}


#Preview {
    EntryView()
}
