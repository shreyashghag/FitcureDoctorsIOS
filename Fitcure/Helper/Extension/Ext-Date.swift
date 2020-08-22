//
//  Ext-Date.swift
//  Fitcure
//
//  Created by Shashikant's_Macmini on 22/08/20.
//  Copyright © 2020 redbytes. All rights reserved.
//

import Foundation

// MARK:- Extension For :- Date
extension Date {
    
    static func getDate(_ str: String?)->Date? {
        guard let strdate = str else { return nil }
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        return dateformatter.date(from: strdate)
    }
    
    static func addDurationOn(date: Date = Date(), component: Calendar.Component = .year, _ years: Int = -8)-> Date? {
        return Calendar.current.date(byAdding: component, value: years, to: date)
    }
    
} //extension
