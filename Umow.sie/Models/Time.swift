//
//  Time.swift
//  Umow.sie
//
//  Created by Bartosz Strzecha on 19/11/2024.
//

struct Time: Codable {
    var hour: Int
    var minute: Int
    var second: Int

    init(hour: Int, minute: Int, second: Int) {
        self.hour = hour
        self.minute = minute
        self.second = second
    }

    init?(from string: String) {
        let components = string.split(separator: ":").map { Int($0) }
        
        guard components.count == 3,
              let hour = components[0], let minute = components[1], let second = components[2],
              (0...23).contains(hour), (0...59).contains(minute), (0...59).contains(second) else {
            return nil
        }
        
        self.hour = hour
        self.minute = minute
        self.second = second
    }
    
    func formatted() -> String {
        return String(format: "%02d:%02d:%02d", hour, minute, second)
    }
}

