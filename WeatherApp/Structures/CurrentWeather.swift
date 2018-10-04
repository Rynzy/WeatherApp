//
//  CurrentWeather.swift
//  WeatherApp
//
//  Created by Joni Ryynänen on 04/10/2018.
//  Copyright © 2018 Joni Ryynänen. All rights reserved.
//

import Foundation

class CurrentWeather : Decodable {
    var coordinates : Coordinate?
    var weather: [Weather]?
    var base: String?
    var main: Main?
    var wind: Wind?
    var clouds: Cloud?
    var dt: Int?
    var sys: Sys?
    var id : Int?
    var name: String?
    var cod: Int?
}
