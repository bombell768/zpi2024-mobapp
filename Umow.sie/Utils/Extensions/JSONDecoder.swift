//
//  JSONDecoder.swift
//  Umow.sie
//
//  Created by Bartosz Strzecha on 20/11/2024.
//

import Foundation

extension JSONDecoder {
    static var withFormattedDates: JSONDecoder {
        let decoder = JSONDecoder()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        decoder.dateDecodingStrategy = .formatted(formatter)
        return decoder
    }
}
