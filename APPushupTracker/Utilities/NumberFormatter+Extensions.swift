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
    formatter.maximumFractionDigits = 4
    
    return formatter
}()

extension NumberFormatter {
    func string(from value: Double) -> String {
        let formattedValue = self.string(from: NSNumber(value: value)) ?? ""
        return (formattedValue == "-0") ? "0" : formattedValue // Workaround for -0
    }
}
