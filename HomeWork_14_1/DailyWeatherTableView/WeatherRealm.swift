//
//  WeatherRealm.swift
//  HomeWork_14_1
//
//  Created by Vlad Ralovich on 9/7/20.
//

import Foundation
import RealmSwift


class WeatherRealm: Object {
    
    @objc dynamic var weatherReNUm: Int = 0
//    var tempRe: Temp
//    var weatherRe = Array<WeatherA>()
    @objc dynamic var timezoneRe: String = ""
    @objc dynamic var dtRe: Int = 0
    @objc dynamic var dayRe: Double = 0.0
    @objc dynamic var nightRe: Double = 0.0
}
