//
//  WeatherModel.swift
//  WeatherApp
//
//  Created by Joni Ryynänen on 01/10/2018.
//  Copyright © 2018 Joni Ryynänen. All rights reserved.
//

import Foundation

class WeatherModel {
    
    var coordinates : Coordinate?
    var usingGPS : Bool
    var city : String
    var currentWeather : CurrentWeather?
    
    init() {
        usingGPS = true
        city = ""
    }
    
}
