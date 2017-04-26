//
//  CurrentWeather.swift
//  WeatherApp
//
//  Created by Andriy Herasymenko on 4/19/17.
//  Copyright © 2017 Andriy Herasymenko. All rights reserved.
//

import Foundation
import UIKit

struct CurrentWeather {
    var temperature: Double
    var apparentTemp: Double
    var humidity: Double
    var pressure: Double
    var icon: UIImage    
}

extension CurrentWeather: JSONDecodable {
    
    init?(JSON: [String : AnyObject]) {
        guard let temperature = JSON["temperature"] as? Double,
            let apparentTemp = JSON["apparentTemperature"] as? Double,
            let humidity = JSON["humidity"] as? Double,
            let pressure = JSON["pressure"] as? Double,
            let iconString = JSON["icon"] as? String else {
                return nil
        }
        
        let icon = WeatherIconManager(rawValue: iconString).image
        
        self.temperature = temperature
        self.apparentTemp = apparentTemp
        self.humidity = humidity
        self.pressure = pressure
        self.icon = icon
    }
    
}

extension CurrentWeather {
    
    var pressureString: String {
        return "\(Int(pressure * 0.750062)) mm"
    }
    
    var humidityString: String {
        return "\(Int(humidity * 100)) %"
    }
    
    var tempString: String {
        return "\(Int(5 / 9 * (temperature - 32)))˚C"
    }
    
    var appearentTempString: String {
        return "Feels like: \(Int(5 / 9 * (apparentTemp - 32)))˚C"
    }
    
}
