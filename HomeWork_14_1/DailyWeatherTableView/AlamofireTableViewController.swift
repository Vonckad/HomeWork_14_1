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
    
    var realm: Realm!

    var weatherRealm: Results<Daily> {
        get {
            return realm.objects(Daily.self)
        }
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
       
        loadWeather()
        
        tableView.backgroundColor = UIColor.init(red: 74/255, green: 187/255, blue: 223/255, alpha: 1.0)
        tableView.register(DailyWeatherTableViewCell.nib(), forCellReuseIdentifier: "DailyWeatherTableViewCell")
        
        realm = try! Realm()
        print(Realm.Configuration.defaultConfiguration.fileURL)
    }
    
    func loadWeather() {
        AlamofireLoader().loadWeather {
            alamofireDate in
            
            let data = alamofireDate.daily
            
            if data == nil{
                try! self.realm.write({

                    self.realm.add(data)
                })
            } else if data == data {
                // это что бы не дублировались данные
                try! self.realm.write({
                    self.realm.delete(self.weatherRealm)
                })
            }
            
            try! self.realm.write({

                self.realm.add(data)
            })
            self.tableView.reloadData()
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return weatherRealm.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "DailyWeatherTableViewCell", for: indexPath) as! DailyWeatherTableViewCell
        cell.configurate(with: self.weatherRealm[indexPath.row])
        return cell
    }
}
