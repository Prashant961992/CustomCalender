//
//  CalenderHelper.swift
//  CalenderDemo
//
//  Created by Prashant on 10/08/18.
//  Copyright © 2018 Prashant. All rights reserved.
//

import UIKit

class CalenderHelper: NSObject {
    static let sharesInstances = CalenderHelper()
    
    func dateFormatterGet() -> DateFormatter {
        let formatter  = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter;
    }
    
    func convertDateFromString(date:String) -> Date {
        let dates = self.dateFormatterGet().date(from: date)
        return dates!
    }
    
    func numberOfdaysInmonth(_ today:String) -> Int {
        let todayDate = self.dateFormatterGet().date(from: today)
        let cal = Calendar(identifier: .gregorian)
        let monthRange = cal.range(of: .day, in: .month, for: todayDate!)!
        return monthRange.count
    }
    
    func getDayOfWeek(_ today:String) -> Int? {
        guard let todayDate = self.dateFormatterGet().date(from: today) else { return nil }
        let myCalendar = Calendar(identifier: .gregorian)
        let weekDay = myCalendar.component(.weekday, from: todayDate)
        return weekDay
    }
    
    func getCurrentmonthFirstDate() -> String {
        let date = Date()
        let year = self.getYear(fromDate: date)
        let month = self.getMonth(fromDate: date)
        
        var cmon = "\(month)"
        if cmon.count == 1{
            cmon = "0\(month)"
        }else{
            cmon = "\(month)"
        }
        let dateis = "\(year)-\(cmon)-01"
        
        return dateis
    }
    
    func getYear(fromDate:Date) -> Int {
        return Calendar.current.component(.year, from: fromDate)
    }
    
    func getMonth(fromDate:Date) -> Int {
        return Calendar.current.component(.month, from: fromDate)
    }
    
    func getDay(fromDate:Date) -> Int {
        return Calendar.current.component(.day, from: fromDate)
    }
    
    func dateisTheSameDay(_ dateA: Date?,dateB: Date?) -> Bool {
        var componentsA : DateComponents = Calendar.current.dateComponents([.year, .day, .month], from: dateA!)
        var componentsB : DateComponents = Calendar.current.dateComponents([.year, .day, .month], from: dateB!)
        return componentsA.year == componentsB.year && componentsA.month == componentsB.month && componentsA.day == componentsB.day
    }
}


