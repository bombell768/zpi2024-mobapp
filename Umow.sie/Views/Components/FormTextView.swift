//
//  FormTextView.swift
//  Umow.sie
//
//  Created by Bartosz Strzecha on 22/11/2024.
//

import SwiftUI

struct FormTextView: View {
  
    @Binding var value: String
    
    var height: CGFloat = 200.0
    
    var body: some View {
        VStack(alignment: .leading) {
            TextEditor(text: $value)
                .frame(maxWidth: .infinity)
                .frame(height: height)
                .padding(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(Color(.systemGray5), lineWidth: 1)
                )
                .padding(.top, 10)
        }
    }
}

#Preview {
    FormTextView(value: .constant(""))
}
