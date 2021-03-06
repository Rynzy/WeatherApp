//
//  Coordinate.swift
//  WeatherApp
//
//  Created by Joni Ryynänen on 04/10/2018.
//  Copyright © 2018 Joni Ryynänen. All rights reserved.
//


class Coordinate : Decodable {
    var lon: Double?
    var lat: Double?
    
    init(longitude: Double, latitude: Double) {
        self.lon = longitude
        self.lat = latitude
    }
}
