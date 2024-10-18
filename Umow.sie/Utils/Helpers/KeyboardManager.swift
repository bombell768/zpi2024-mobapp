//
//  KeyboardManager.swift
//  Umow.sie
//
//  Created by Bartosz Strzecha on 15/10/2024.
//

import SwiftUI
import Combine

class KeyboardManager: ObservableObject {
    // Przechowuje informację o widoczności klawiatury
    @Published var isKeyboardVisible: Bool = false

    private var cancellables: Set<AnyCancellable> = [] // Zbiór subskrypcji

    init() {
        // Obserwujemy powiadomienia systemowe o stanie klawiatury
        NotificationCenter.default.publisher(for: UIResponder.keyboardDidShowNotification)
            .sink { _ in
                self.isKeyboardVisible = true
            }
            .store(in: &cancellables)

        NotificationCenter.default.publisher(for: UIResponder.keyboardDidHideNotification)
            .sink { _ in
                self.isKeyboardVisible = false
            }
            .store(in: &cancellables)
    }
}

