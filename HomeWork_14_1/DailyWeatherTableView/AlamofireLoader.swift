//
//  AlamofireLoader.swift
//  HomeWork_12_Carthage
//
//  Created by Vlad Ralovich on 6/18/20.
//  Copyright © 2020 Vonkad. All rights reserved.
//

import Foundation
import Alamofire

class AlamofireLoader {
    
    func loadWeather(completion: @escaping (DailyDate) -> Void) {
        Alamofire.request("https://api.openweathermap.org/data/2.5/onecall?lat=55.7522200&lon=37.6155600&daily=7&appid=c54f405569613556a8b049e8058b8be2&lang=ru&units=metric").responseJSON { response in
            
            var json: DailyDate?
            do {
                
                json = try JSONDecoder().decode(DailyDate.self, from: response.data!)
            }
            catch {
                print("error2 === ", error)
            }
            
            guard let result = json else {
                return
            }
            DispatchQueue.main.async {
                completion(result)
            }
        }
    }
}

