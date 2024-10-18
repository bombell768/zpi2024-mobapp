//
//  HideKeyboardOnSwipe.swift
//  Umow.sie
//
//  Created by Bartosz Strzecha on 15/10/2024.
//

import SwiftUI

struct HideKeyboardOnGesture: ViewModifier {
    @ObservedObject var keyboardManager = KeyboardManager() // Obserwujemy stan klawiatury

    func body(content: Content) -> some View {
        content
            // Dodaj gest przeciągnięcia (swipe down)
            .simultaneousGesture(
                DragGesture(minimumDistance: 10, coordinateSpace: .local)
                    .onEnded { value in
                        if value.translation.height > 0 {
                            UIApplication.shared.hideKeyboard()
                        }
                    }
            )
            // Dodaj gest tapnięcia tylko, gdy klawiatura jest widoczna
            .simultaneousGesture(
                TapGesture()
                    .onEnded {
                        if keyboardManager.isKeyboardVisible {
                            UIApplication.shared.hideKeyboard()
                        }
                    }
            )
    }
}

extension View {
    // Modyfikator dla tapnięcia i swipe, kontrolujący stan klawiatury
    func hideKeyboardOnGesture() -> some View {
        self.modifier(HideKeyboardOnGesture())
    }
}
