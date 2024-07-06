//
//  NumberFormatter+Extensions.swift
//  APPushupTracker
//
//  Created by Emily Corso on 7/6/24.
//

import Foundation


let decimalFormatter: NumberFormatter = {
    let formatter = NumberFormatter()
    
    formatter.numberStyle = .decimal
    formatter.maximumFractionDigits = 2
    
    return formatter
}()

extension NumberFormatter {
    func string(from value: Double) -> String {
        return self.string(from: NSNumber(value: value)) ?? ""
    }
}
