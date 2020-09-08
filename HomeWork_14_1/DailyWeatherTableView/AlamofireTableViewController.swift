//
//  AlamofireViewController.swift
//  HomeWork_12_Carthage
//
//  Created by Vlad Ralovich on 6/17/20.
//  Copyright © 2020 Vonkad. All rights reserved.
//

import UIKit
import RealmSwift

class AlamofireTableViewController: UITableViewController {

    @IBOutlet var headView: UIView!
    var myDailyDate = [Daily]()
    var numberCoRe = 0
    var weatherReal: Realm!
    var weatherRe: Results<WeatherRealm> {
        get {
            return weatherReal.objects(WeatherRealm.self)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        weatherReal = try! Realm()
        
        loadWeather()
        tableView.backgroundColor = UIColor.init(red: 74/255, green: 187/255, blue: 223/255, alpha: 1.0)
        tableView.register(DailyWeatherTableViewCell.nib(), forCellReuseIdentifier: "DailyWeatherTableViewCell")
    }
    
    func loadWeather() {
        AlamofireLoader().loadWeather {
            alamofireDate in
            let data = alamofireDate.daily
            self.myDailyDate.append(contentsOf: data)
            let numberCount = WeatherRealm()
                           numberCount.weatherReNUm = self.myDailyDate.count
            try! self.weatherReal.write({
               
            self.weatherReal.add(numberCount)
                self.numberCoRe =N numberCount.weatherReNUm
            })
            
            self.tableView.reloadData()
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberCoRe
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "DailyWeatherTableViewCell", for: indexPath) as! DailyWeatherTableViewCell
        cell.configurate(with: self.myDailyDate[indexPath.row])

        return cell
    }
}
