//
//  Ext-String.swift
//  Fitcure
//
//  Created by Shashikant's_Macmini on 09/08/20.
//  Copyright © 2020 redbytes. All rights reserved.
//
import Foundation

// MARK:- Extension For :- String
extension String {
    
    static func getDate(_ str: String?)->String {
        guard let strdate = str else { return "" }
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        let date = dateformatter.date(from: strdate)
        guard let date1 = date else { return strdate }
        dateformatter.dateFormat = "E, d MMM yyyy HH:mm"
        return dateformatter.string(from: date1)
    }
    static func getDate(_ date: Date)->String {
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "E, d MMM yyyy HH:mm"
        return dateformatter.string(from: date)
    }
    static func getTime(_ date: Date)->String {
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "hh:mm a"
        return dateformatter.string(from: date)
    }
    func fileExtension() -> String {
        return URL(fileURLWithPath: self).pathExtension
    }
    
} //extension
