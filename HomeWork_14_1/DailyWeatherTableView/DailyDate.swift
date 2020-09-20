//
//  WeatherDataAlamofire.swift
//  HomeWork_12_Carthage
//
//  Created by Vlad Ralovich on 6/18/20.
//  Copyright © 2020 Vonkad. All rights reserved.
//

import Foundation
import RealmSwift

@objcMembers class DailyDate: Object, Codable {

    var daily = List<Daily>()
    @objc dynamic var timezone: String = ""
}

class Daily: Object, Codable {
    @objc dynamic var dt: Int = 0
    @objc dynamic var temp: Temp?
    var weather = List<WeatherA>()
}

class Temp: Object, Codable {
    @objc dynamic var day: Double = 0.0
    @objc dynamic var night: Double = 0.0
}

class WeatherA: Object, Codable{
    @objc dynamic var main: String = ""
}
