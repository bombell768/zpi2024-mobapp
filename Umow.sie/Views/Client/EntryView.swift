//
//  EntryView.swift
//  Umow.sie
//
//  Created by Bartosz Strzecha on 05/12/2024.
//

import SwiftUI

struct EntryView: View {
    @AppStorage("isLoggedIn") private var isLoggedIn: Bool = false
    @AppStorage("authToken") private var authToken: String?
    @AppStorage("userRole") private var userRole: UserRole?
    
    var body: some View {
        Group {
            if userRole == .client && isLoggedIn  {
                MainView()
            }
            else if userRole == .employee && isLoggedIn {
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
