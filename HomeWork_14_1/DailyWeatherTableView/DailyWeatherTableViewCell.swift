//
//  DailyWeatherTableViewCell.swift
//  HomeWork_12_Carthage
//
//  Created by Vlad Ralovich on 6/22/20.
//  Copyright © 2020 Vonkad. All rights reserved.
//

import UIKit
//import Gifu

class DailyWeatherTableViewCell: UITableViewCell {

    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var tempLabelDay: UILabel!
    @IBOutlet var tempLabelNight: UILabel!
    @IBOutlet var myImage: UIImageView!
    
//    var nameWeatherIconGif: String = "Load"
//    var weatherIconGif = GIFImageView()
    
    override func awakeFromNib() {
        super.awakeFromNib()
         
//        weatherIconGif = GIFImageView(frame: CGRect(x: 0, y: 0, width: myImage.frame.width, height: myImage.frame.height))
//        weatherIconGif.contentMode = .scaleAspectFit
    }

    static func nib() -> UINib {
        return UINib(nibName: "DailyWeatherTableViewCell", bundle: nil)
    }
    
    func configurate(with model: Daily)  {
        tempLabelDay.text = "\(Int(model.temp!.day)) ℃"
        tempLabelNight.text = "\(Int(model.temp!.night)) ℃"
        dateLabel.text = getDate(Date(timeIntervalSince1970: Double(model.dt)))
        
//        nameWeatherIconGif = model.weather[0].main
//        weatherIconGif.animate(withGIFNamed: nameWeatherIconGif)
//        myImage.addSubview(weatherIconGif)
    }
    
    func getDate(_ date: Date?) -> String {
        guard let inputDate = date else {
            return ""
        }
        let formattet = DateFormatter()
        formattet.dateFormat = "dd MMM, EEEE"
        return formattet.string(from: inputDate)
    }
    
}
