//
//  WeatherDataAlamofire.swift
//  HomeWork_12_Carthage
//
//  Created by Vlad Ralovich on 6/18/20.
//  Copyright © 2020 Vonkad. All rights reserved.
//

import Foundation

struct DailyDate: Codable {
    
    var daily: [Daily]
    var timezone: String
}

struct Daily: Codable {
    var dt: Int
    var temp: Temp
    var weather: [WeatherA]
}

struct Temp: Codable {
    var day: Double
    var night: Double
}

struct WeatherA: Codable {
    var main: String
}

