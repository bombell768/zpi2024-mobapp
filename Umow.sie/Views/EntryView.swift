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
    
    var body: some View {
        
        Group {
            if isLoggedIn {
                MainView()
            } else {
                LoginView()
            }
        }

    }
}


#Preview {
    EntryView()
}
