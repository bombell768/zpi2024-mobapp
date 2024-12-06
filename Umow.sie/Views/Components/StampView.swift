//
//  StampView.swift
//  Umow.sie
//
//  Created by Bartosz Strzecha on 05/12/2024.
//

import SwiftUI

struct StampView: View {
    let earnedStamps: Int
    let totalStamps = 10

    var body: some View {
        VStack(spacing: 8) {
            HStack {
                ForEach(0..<5, id: \.self) { index in
                    Image(systemName: index < earnedStamps ? "seal.fill" : "seal")
                        .font(.system(size: 50))
                        .foregroundStyle(Color.ui.vanilla)
                }
            }
            
            HStack {
                ForEach(5..<10, id: \.self) { index in
                    Image(systemName: index < earnedStamps ? "seal.fill" : "seal")
                        .font(.system(size: 50))
                        .foregroundStyle(Color.ui.vanilla)
                }
            }
            
            Text("Zbierz jeszcze \(max(0, totalStamps - earnedStamps)) \(stampText(for: max(0, totalStamps - earnedStamps))) do darmowej wizyty!")
                .font(.system(size: 18))
                .padding(.top, 30)
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity, alignment: .center)
    }
    
    // Funkcja pomocnicza do odmiany wyrazu "pieczątki"
    private func stampText(for count: Int) -> String {
        switch count {
        case 1:
            return "pieczątkę"
        case 2...4:
            return "pieczątki"
        default:
            return "pieczątek"
        }
    }
}


#Preview {
    StampView(earnedStamps: 10)
}
