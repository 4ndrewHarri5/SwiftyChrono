//
//  TestUtil.swift
//  SwiftyChrono
//
//  Created by Jerry Chen on 1/23/17.
//  Copyright © 2017 Potix. All rights reserved.
//
import Foundation
import XCTest

extension XCTestCase {
    func ok(_ result: Bool) {
        XCTAssert(result)
    }
    
    func ok(_ result: Bool, _ message: String) {
        XCTAssert(result, message)
    }
    
    public struct JSON {
        static func stringify(_ value: Any) -> String {
            if let data = try? JSONSerialization.data(withJSONObject: value, options: .prettyPrinted) {
                return String(data: data, encoding: String.Encoding.utf8) ?? ""
            } else {
                return ""
            }
        }
    }
}

extension Chrono {
    func parse(_ text: String, _ refDate: Date = Date(), _ opt: [OptionType: Int] = [:]) -> [ParsedResult] {
        return parse(text: text, refDate: refDate, opt: opt)
    }
}

extension Date {
    init(valueString: String) {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZ" // ISO 8601
        let date = dateFormatter.date(from: valueString)
        
        if let date = date {
            self = date
        } else {
            dateFormatter.dateFormat = "EEE, dd MMM yyyy HH:mm:ss Z"; //RFC2822-Format
            self = dateFormatter.date(from: valueString) ?? Date()
        }
    }
    
    /// ATTENTION: this is Javascript compatible init function.
    /// the range of month is between 0 ~ 11
    init(_ year: Int, _ month: Int, date: Int = 1, _ hours: Int = 0, _ minutes: Int = 0, seconds: Int = 0, milliseconds: Int = 0) {
        
        let component = DateComponents(calendar: cal, timeZone: TimeZone.current, year: year, month: month, day: date, hour: hours, minute: minutes, second: seconds, nanosecond: milliseconds * 1000)
        self = component.date ?? Date()
    }
    
    static let iso8601Formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSXXXXX"
        return formatter
    }()
    var iso8601: String {
        return Date.iso8601Formatter.string(from: self)
    }
}

extension Array {
    var length: Int {
        return Int(count)
    }
}


extension String {
    var dateFromISO8601: Date? {
        return Date.iso8601Formatter.date(from: self)
    }
}
