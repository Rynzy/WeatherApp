//
//  List.swift
//  WeatherApp
//
//  Created by Joni Ryynänen on 09/10/2018.
//  Copyright © 2018 Joni Ryynänen. All rights reserved.
//

import Foundation

class List : Decodable {
    
    var dt: Int?
    var main: Main?
    var weather: [Weather]?
    var clouds: Cloud?
    var wind: Wind?
    var sys: Sys?
    var dt_txt: String?
}
