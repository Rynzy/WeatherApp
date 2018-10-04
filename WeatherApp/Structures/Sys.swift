//
//  Sys.swift
//  WeatherApp
//
//  Created by Joni Ryynänen on 04/10/2018.
//  Copyright © 2018 Joni Ryynänen. All rights reserved.
//

import Foundation

class Sys : Decodable {
    
    var type : Int?
    var id : Int?
    var message : Double?
    var country : String?
    var sunrise : Int?
    var sunset : Int?
}
