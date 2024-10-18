//
//  KeyboardHelper.swift
//  Umow.sie
//
//  Created by Bartosz Strzecha on 15/10/2024.
//

import SwiftUI

extension UIApplication {
    func hideKeyboard() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
