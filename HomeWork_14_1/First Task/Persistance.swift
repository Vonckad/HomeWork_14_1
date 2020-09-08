//
//  Persistance.swift
//  HomeWork_14_1
//
//  Created by Vlad Ralovich on 8/13/20.
//

import Foundation
class Persistance {
    static let share = Persistance()
    
    private let kFistrUserName = "Persistance.share.first"
    
    var firstUserName: String? {
        set {UserDefaults.standard.set(newValue, forKey: kFistrUserName)}
        get {return UserDefaults.standard.string(forKey: kFistrUserName)}
    }

    private let kLastUserName = "Persistance.share.last"
    
    var lastUserName: String? {
        set {UserDefaults.standard.set(newValue, forKey: kLastUserName)}
        get {return UserDefaults.standard.string(forKey: kLastUserName)}
    }

}
