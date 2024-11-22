//
//  Time.swift
//  Umow.sie
//
//  Created by Bartosz Strzecha on 19/11/2024.
//

struct Time: Codable, Equatable, Hashable {
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
        return String(format: "%02d:%02d", hour, minute)
    }
}

extension Time {
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let timeString = try container.decode(String.self)
        
        guard let time = Time(from: timeString) else {
            throw DecodingError.dataCorruptedError(
                in: container,
                debugDescription: "Invalid time format: \(timeString)"
            )
        }
        
        self = time
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(self.formatted())
    }
}


extension Time {
    func adding(minutes: Int) -> Time {
        var totalMinutes = self.hour * 60 + self.minute + minutes
        let newHour = totalMinutes / 60
        totalMinutes %= 60
        let newMinute = totalMinutes
        return Time(hour: newHour % 24, minute: newMinute, second: self.second)
    }
    
    static func <(lhs: Time, rhs: Time) -> Bool {
        if lhs.hour != rhs.hour { return lhs.hour < rhs.hour }
        if lhs.minute != rhs.minute { return lhs.minute < rhs.minute }
        return lhs.second < rhs.second
    }
}
