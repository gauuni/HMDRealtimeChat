//
//  NSDateExtension.swift
//  KiDi
//
//  Created by Tan Tran on 3/8/16.
//
//

import UIKit

extension NSDate {
    func dateStringWithFormat(format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self as Date)
    }
    
    func isGreaterThanDate(dateToCompare: NSDate) -> Bool {
        //Declare Variables
        var isGreater = false
        
        //Compare Values
        if self.compare(dateToCompare as Date) == ComparisonResult.orderedDescending {
            isGreater = true
        }
        
        //Return Result
        return isGreater
    }
    
    func isLessThanDate(dateToCompare: NSDate) -> Bool {
        //Declare Variables
        var isLess = false
        
        //Compare Values
        if self.compare(dateToCompare as Date) == ComparisonResult.orderedAscending {
            isLess = true
        }
        
        //Return Result
        return isLess
    }
    
    func equalToDate(dateToCompare: NSDate) -> Bool {
        //Declare Variables
        var isEqualTo = false
        
        //Compare Values
        if self.compare(dateToCompare as Date) == ComparisonResult.orderedSame {
            isEqualTo = true
        }
        
        //Return Result
        return isEqualTo
    }
    
    func addDays(daysToAdd: Int) -> NSDate {
        let secondsInDays: TimeInterval = Double(daysToAdd) * 60 * 60 * 24
        let dateWithDaysAdded: NSDate = self.addingTimeInterval(secondsInDays)
        
        //Return Result
        return dateWithDaysAdded
    }
    
    func addHours(hoursToAdd: Int) -> NSDate {
        let secondsInHours: TimeInterval = Double(hoursToAdd) * 60 * 60
        let dateWithHoursAdded: NSDate = self.addingTimeInterval(secondsInHours)
        
        //Return Result
        return dateWithHoursAdded
    }
}

extension Date {
    // 48 minutes ago
    // 3 hour ago
    // Yesterday at 2:15 PM
    // Oct 15 at 7:00 AM
    func dateForPost() -> String {
        var timeResponse = ""
        if self.isToday() {
            let time = timeAgoSinceDate(date: self as NSDate, numericDates: true)
            timeResponse = time
        } else if self.isYesterday() {
            let dayTimePeriodFormatter = DateFormatter()
            dayTimePeriodFormatter.dateFormat = "H:mm a"
            let dateString = dayTimePeriodFormatter.string(from: self)
            let time = "Yesterday at " + dateString
            timeResponse = time
        } else if self.isThisWeek() {
            let dayTimePeriodFormatter = DateFormatter()
            dayTimePeriodFormatter.dateFormat = "EEEE 'at' H:mm a"
            let dateString = dayTimePeriodFormatter.string(from: self)
            timeResponse = dateString
        } else {
            let dayTimePeriodFormatter = DateFormatter()
            dayTimePeriodFormatter.dateFormat = "MMM d 'at' H:mm a"
            let dateString = dayTimePeriodFormatter.string(from: self)
            timeResponse = dateString
        }
        
        return timeResponse
    }
    
    func timeAgoSinceDate(date:NSDate, numericDates:Bool) -> String {
        let calendar = NSCalendar.current
        let now = NSDate()
        let earliest = now.earlierDate(date as Date)
        let latest = (earliest == now as Date) ? date : now
        
        let unitFlags = Set<Calendar.Component>([.minute, .hour, .day, .weekOfYear, .month , .year , .second])
        let components = calendar.dateComponents(unitFlags, from: earliest,  to: latest as Date)
        
        let year = components.year ?? 0
        let month = components.month ?? 0
        let weekOfYear = components.weekOfYear ?? 0
        let day = components.day ?? 0
        let hour = components.hour ?? 0
        let minute = components.minute ?? 0
        let second = components.second ?? 0
        
        
        if (year >= 2) {
            return "\(components.year) years ago"
        } else if (year >= 1){
            if (numericDates){
                return "1 year ago"
            } else {
                return "Last year"
            }
        } else if (month >= 2) {
            return "\(month) months ago"
        } else if (month >= 1){
            if (numericDates){
                return "1 month ago"
            } else {
                return "Last month"
            }
        } else if (weekOfYear >= 2) {
            return "\(weekOfYear) weeks ago"
        } else if (weekOfYear >= 1){
            if (numericDates){
                return "1 week ago"
            } else {
                return "Last week"
            }
        } else if (day >= 2) {
            return "\(day) days ago"
        } else if (day >= 1){
            if (numericDates){
                return "1 day ago"
            } else {
                return "Yesterday"
            }
        } else if (hour >= 2) {
            return "\(hour) hours ago"
        } else if (hour >= 1){
            if (numericDates){
                return "1 hour ago"
            } else {
                return "An hour ago"
            }
        } else if (minute  >= 2) {
            return "\(minute) minutes ago"
        } else if (minute >= 1){
            if (numericDates){
                return "1 minute ago"
            } else {
                return "A minute ago"
            }
        } else if (second >= 3) {
            return "\(second) seconds ago"
        } else {
            return "Just now"
        }
    }
    

    static var currentTimeInterval: String{
        return "\(Date().timeIntervalSince1970*1000)"
    }
    
    static var currentTimeIntervalDouble: Double{
        return Double(Date().timeIntervalSince1970)
    }
}



