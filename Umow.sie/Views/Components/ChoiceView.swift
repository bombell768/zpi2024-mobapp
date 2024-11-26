//
//  TimeSlotView.swift
//  Umow.sie
//
//  Created by Bartosz Strzecha on 10/11/2024.
//

import SwiftUI

struct ChoiceView: View {
    let text: String
    let isSelected: Bool
        
    var body: some View {
        Text(text)
            .font(.headline)
            .padding()
            .padding(.horizontal, 5)
            .frame(minWidth: 90)
            .frame(height: 45)
            .background(isSelected ? Color.ui.vanilla : Color.ui.cultured.opacity(0.9))
            .foregroundColor(isSelected ? .black.opacity(0.9) : .white)
            .cornerRadius(10)
    }
}

#Preview {
    VStack {
        ChoiceView(text: "9:00", isSelected: true)
            
        ChoiceView(text: "10:15", isSelected: false)
        
        ChoiceView(text: "Michał", isSelected: true)
        
        ChoiceView(text: "Radosław", isSelected: false)

    }
    .padding()
}
