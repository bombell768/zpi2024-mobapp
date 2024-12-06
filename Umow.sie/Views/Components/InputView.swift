//
//  InputView.swift
//  Umow.sie
//
//  Created by Bartosz Strzecha on 08/10/2024.
//

import SwiftUI

struct InputView: View {
    @Binding var text: String
    let title: String
    let placeholder: String
    var isSecureField: Bool = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(title)
                .font(.system(size: 15))
                .foregroundColor(Color.white)
                .fontWeight(.semibold)
            
            if isSecureField {
                SecureField(placeholder, text: $text)
                    .font(.system(size: 14))
                    .padding(10)
                    .background(Color.ui.cultured)
                    .cornerRadius(8)
                    .frame(maxWidth: .infinity)
            } else {
                TextField(placeholder, text: $text)
                    .font(.system(size: 14))
                    .padding(10)
                    .background(Color.ui.cultured)
                    .cornerRadius(8)
                    .frame(maxWidth: .infinity)
            }
            
        }
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    InputView(text: .constant(""), title: "Adres e-mail", placeholder: "name@gmail.com")
}

