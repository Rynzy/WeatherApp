//
//  Utils.swift
//  WeatherApp
//
//  Created by Joni Ryynänen on 04/10/2018.
//  Copyright © 2018 Joni Ryynänen. All rights reserved.
//

import Foundation

class Utils {
    
    
    static func kelvinToCelsius(degrees: Double) -> Double {
        let formatter = NumberFormatter()
        let number = NSNumber(value: degrees - 273.15)
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 1
        let fixed = String(formatter.string(from: number) ?? "")
        let end = Double(fixed)
        
        return end!
    }
    
}
