//
//  Date+Ext.swift
//  LululemonChallenge
//
//  Created by Jason Dhindsa on 2021-08-28.
//

import Foundation

extension Date {
    static func convertDateToString(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d, yyyy, h:mm a"
        return formatter.string(from: date)
    }
}
