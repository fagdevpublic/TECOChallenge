//
//  DateHandlerExtension.swift
//  WeatherChallenge
//
//  Created by Flavio Andres Gomez on 27/06/2023.
//

import Foundation

extension Date {
    public func getDates(range: Int?) -> [Date] {
        let currentDate = Calendar.current.startOfDay(for: Date())
        var dates = [currentDate]
        while (dates.count < range ?? 5)  {
            guard let dateToAppend = currentDate.addDays(.day, NumOfDays: dates.count) else { return []}
            dates.append(dateToAppend)
        }
        return dates
    }
    
    public func dayOfWeek(with unixTime: Int) -> String? {
        let index = Calendar.current.component(.weekday, from: convertUnixTime(with: unixTime))
        return Calendar.current.weekdaySymbols[index - 1]
    }
    
    public func dayUnixDateCompare(with unix: Int, and date: Date) -> Bool{
        let unixDateConverted = convertUnixTime(with: unix)
        
        let result = Calendar.current.compare(unixDateConverted, to: date, toGranularity: .day)
        
        switch result {
        case .orderedAscending:
            return false
        case .orderedSame:
            return true
        case .orderedDescending:
            return false
        }
    }
    
    public func dayUnixUnixCompare(with unix1Date: Int, and unix2Date: Int) -> Bool{
        let unix1DateConverted = convertUnixTime(with: unix1Date)
        let unix2DateConverted = convertUnixTime(with: unix2Date)
        
        let result = Calendar.current.compare(unix1DateConverted, to: unix2DateConverted, toGranularity: .day)
        
        switch result {
        case .orderedAscending:
            return false
        case .orderedSame:
            return true
        case .orderedDescending:
            return false
        }
    }
    
    private func convertUnixTime(with unixTime: Int) -> Date {
        let date = Date(timeIntervalSince1970: TimeInterval(unixTime))
        return date
    }
    
    private func addDays(_ unit: Calendar.Component, NumOfDays: Int) -> Date? {
        return Calendar.current.date(byAdding: unit, value: NumOfDays, to: self)
    }
    

}


