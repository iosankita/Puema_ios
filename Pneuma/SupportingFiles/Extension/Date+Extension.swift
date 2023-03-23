//
//  Date+Extension.swift
//  Pneuma
//
//  Created by Chitra on 24/02/21.
//  Copyright © 2021 iTechnolabs. All rights reserved.
//

import Foundation

enum DateFormat: String {
    case timeWith12Hour = "hh:mm a"
    case standard = "dd/MMM/yyyy"
    case timeWith24Hour = "HH:mm"
    case appDate = "dd/mm/yyy"
    case dateMonth = "EEE, MMM dd"
    case boundFlightTime = "dd MMM, hh:mm a"
    case FlightTime = "dd MMM, hh:mm"
    case Fdate = "yyyy-MM-dd'T'HH:mm:ssZ"
    case tripDate = "dd.MM.yy"
    case fullDate = "yyyy-MM-dd"
    
}

struct DateModel {
    var years: Int?
    var months: Int?
    var days: Int?
    var hours: Int?
    var minutes: Int?
}

extension Date {
    static var yesterday: Date { return Date().dayBefore }
    static var tomorrow:  Date { return Date().dayAfter }
    static var week:  Date { return Date().dayWeek }
    var dayBefore: Date {
        return Calendar.current.date(byAdding: .day, value: -1, to: noon)!
    }
    var dayAfter: Date {
        return Calendar.current.date(byAdding: .day, value: 1, to: noon)!
    }
    var dayWeek: Date {
        return Calendar.current.date(byAdding: .day, value: 7, to: noon)!
    }
    var noon: Date {
        return Calendar.current.date(bySettingHour: 12, minute: 0, second: 0, of: self)!
    }
    var month: Int {
        return Calendar.current.component(.month,  from: self)
    }
    var isLastDayOfMonth: Bool {
        return dayAfter.month != month
    }
    
    var millisecondsSince1970:Int {
        return Int((self.timeIntervalSince1970).rounded())
    }
    
    var millisecondsSince1970MultiplyBy10:Int {
        return Int((self.timeIntervalSince1970 * 10.0).rounded())
    }
    
    var millisecondsSince1970MultiplyBy1000:Int {
        return Int((self.timeIntervalSince1970 * 1000.0).rounded())
    }
    
    init(milliseconds:Int) {
        self = Date(timeIntervalSince1970: TimeInterval(milliseconds))
    }
    
    init(millisecondsDividedBy10:Int) {
        self = Date(timeIntervalSince1970: TimeInterval(millisecondsDividedBy10) / 10)
    }
    
    init(millisecondsDividedBy1000:Int) {
        self = Date(timeIntervalSince1970: TimeInterval(millisecondsDividedBy1000) / 1000)
    }
    
    var isDateInToday: Bool {
        let todayDateString = Date().getString(format: .standard)
        let todayDate = Date.dateFromString(todayDateString, format: .standard) ?? Date()
        let resultDateString = self.getString(format: .standard)
        let resultDate = Date.dateFromString(resultDateString, format: .standard) ?? Date()
        return Calendar.current.isDate(resultDate, inSameDayAs: todayDate)
    }
    
    func getString(format: DateFormat = .timeWith12Hour, timeZone: TimeZone = .current) -> String {
        let formatter = DateFormatter()
        formatter.timeZone = timeZone
        formatter.dateFormat = DateFormat.standard.rawValue
        
        let dateString = formatter.string(from: self)
        let date = formatter.date(from: dateString)
        formatter.dateFormat = format.rawValue
        let timeString = formatter.string(from: date!)
        return timeString
    }
    
    func getStringFullDate(format: DateFormat = .timeWith12Hour, timeZone: TimeZone = .current) -> String {
        let formatter = DateFormatter()
        formatter.timeZone = timeZone
        formatter.dateFormat = DateFormat.standard.rawValue + DateFormat.timeWith12Hour.rawValue
        
        let dateString = formatter.string(from: self)
        let date = formatter.date(from: dateString)
        formatter.dateFormat = format.rawValue
        let timeString = formatter.string(from: date!)
        return timeString
    }
    
    func getStringFullDate2(format: DateFormat = .timeWith12Hour, timeZone: TimeZone = .current) -> String {
        let formatter = DateFormatter()
        formatter.timeZone = timeZone
        formatter.dateFormat = DateFormat.Fdate.rawValue
        
        let dateString = formatter.string(from: self)
        let date = formatter.date(from: dateString)
        formatter.dateFormat = format.rawValue
        let timeString = formatter.string(from: date!)
        return timeString
    }
    
    func getString(currentFormat: DateFormat = .appDate, newFormat: DateFormat = .timeWith12Hour, timeZone: TimeZone = .current) -> String {
        let formatter = DateFormatter()
        formatter.timeZone = timeZone
        formatter.dateFormat = currentFormat.rawValue
        
        let dateString = formatter.string(from: self)
        let date = formatter.date(from: dateString)
        formatter.dateFormat = newFormat.rawValue
        let timeString = formatter.string(from: date!)
        return timeString
    }
    
    func getDate(format: DateFormat = .standard) -> Date? {
        let dateString = self.getString(format: format)
        let date = Date.dateFromString(dateString, format: format)
        return date
    }
    
    static func dateFromString(_ dateString: String, format: DateFormat, timeZone: TimeZone = .current) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format.rawValue
        dateFormatter.timeZone = timeZone
        let date = dateFormatter.date(from: dateString)
        return date
    }
    
    
    func offsetFrom(_ date: Date?) -> String {

        let dayHourMinuteSecond: Set<Calendar.Component> = [.day, .hour, .minute, .second]
        let difference = NSCalendar.current.dateComponents(dayHourMinuteSecond, from:self, to:  date ?? Date())

        let seconds = "\(difference.second ?? 0)s"
        let minutes = difference.second == 0 ? "\(difference.minute ?? 0)m" : "\(difference.minute ?? 0)m" + " " + seconds
        let hours = "\(difference.hour ?? 0)h" + " " + minutes
        if let hour = difference.hour, hour > 0 { return hours }
        if let minute = difference.minute, minute > 0 { return minutes }
        if let second = difference.second, second > 0 { return seconds }
        return ""
    }
    
    func timeAgoSinceDate( _ pretoDate : Date? = Date() ) -> String {
        // From Time
        let fromDate = self
        // To Time
        let toDate = pretoDate ?? Date()
        
        // Estimation
        // Year
        if let interval = Calendar.current.dateComponents([.year], from: fromDate, to: toDate).year, interval > 0  {
            return interval == 1 ? "\(interval)" + " " + "year ago" : "\(interval)" + " " + "years ago"
        }
        // Month
        if let interval = Calendar.current.dateComponents([.month], from: fromDate, to: toDate).month, interval > 0  {
            return interval == 1 ? "\(interval)" + " " + "month ago" : "\(interval)" + " " + "months ago"
        }
        // Day
        if let interval = Calendar.current.dateComponents([.day], from: fromDate, to: toDate).day, interval > 0  {
            return interval == 1 ? "\(interval)" + " " + "day ago" : "\(interval)" + " " + "days ago"
        }
        // Hours
        if let interval = Calendar.current.dateComponents([.hour], from: fromDate, to: toDate).hour, interval > 0 {
            return interval == 1 ? "\(interval)" + " " + "hour ago" : "\(interval)" + " " + "hours ago"
        }
        // Minute
        if let interval = Calendar.current.dateComponents([.minute], from: fromDate, to: toDate).minute, interval > 0 {
            return interval == 1 ? "\(interval)" + " " + "minute ago" : "\(interval)" + " " + "minutes ago"
        }
        return "a moment ago"
    }
    
    func timeTillDate(_ date: Date) -> DateModel {
        // From Time
        let fromDate = self
        var dateModel = DateModel()
        
        
        if let interval = Calendar.current.dateComponents([.year], from: fromDate, to: date).year, interval > 0  {
            dateModel.years = interval
        }
        // Month
        if let interval = Calendar.current.dateComponents([.month], from: fromDate, to: date).month, interval > 0  {
            dateModel.months = interval
        }
        // Day
        if let interval = Calendar.current.dateComponents([.day], from: fromDate, to: date).day, interval > 0  {
            dateModel.days = interval
        }
        // Hours
        if let interval = Calendar.current.dateComponents([.hour], from: fromDate, to: date).hour, interval > 0 {
            dateModel.hours = interval
        }
        // Minute
        if let interval = Calendar.current.dateComponents([.minute], from: fromDate, to: date).minute, interval > 0 {
            dateModel.minutes = interval
        }
        return dateModel
    }
    
    func getDaysFromDate(_ date: Date) -> Int {
        let calendar = Calendar.current
        
        // Replace the hour (time) of both dates with 00:00
        let date1 = calendar.startOfDay(for: self)
        let date2 = calendar.startOfDay(for: date)
        
        let components = calendar.dateComponents([.day], from: date1, to: date2)
        return components.day ?? 0
    }
}
extension Date {
   
    init(milliseconds:Int64) {
        self = Date(timeIntervalSince1970: TimeInterval(milliseconds) / 1000)
    }
}
extension TimeInterval{

        func stringFromTimeInterval() -> String {

            let time = NSInteger(self)

            let ms = Int((self.truncatingRemainder(dividingBy: 1)) * 1000)
            let seconds = time % 60
            let minutes = (time / 60) % 60
            let hours = (time / 3600)

            return String(format: "%0.2d:%0.2d:%0.2d.%0.3d",hours,minutes,seconds,ms)

        }
    func stringFromDurationInterval() -> String {

        let time = NSInteger(self)

        let ms = Int((self.truncatingRemainder(dividingBy: 1)) * 1000)
        let minutes = time % 60
        let hours = (time / 60) % 60
        

        return String(format: "%0.1d hr %0.1d m",hours,minutes)

    }
    }
