//
//  WeatherVC.swift
//  WeatherApp
//
//  Created by Andriy Herasymenko on 4/19/17.
//  Copyright © 2017 Andriy Herasymenko. All rights reserved.
//

import UIKit
import CoreLocation

class WeatherVC: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var locationLbl: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var pressureLbl: UILabel!
    @IBOutlet weak var humidityLbl: UILabel!
    @IBOutlet weak var temperatureLbl: UILabel!
    @IBOutlet weak var appearentTempLbl: UILabel!
    @IBOutlet weak var refreshBtn: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    let locationManager = CLLocationManager()
    
    
    @IBAction func refreshBtnPressed(_ sender: UIButton) {
        toggleActivityindicator(on: true)
        getCurrentWeatherData()
    }
    
    func toggleActivityindicator(on: Bool) {
        refreshBtn.isHidden = on
        
        if on {
            activityIndicator.startAnimating()
        } else {
            activityIndicator.stopAnimating()
        }
    }
    
    lazy var weatherManager = APIWeatherManager(apiKey: "4479b07876e9f9b8f4f3d908faa1111c")
    let coordinates = Coordinates(latitude: 25.300782, longitude: 55.380282)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        
        getCurrentWeatherData()
        
        //        let icon = WeatherIconManager.ClearDay.image
        //
        //        let currentWeather = CurrentWeather(temperature: 15.0, apparentTemp: 12.0, humidity: 35.0, pressure: 750.0, icon: icon)
        
        //        updateUIWith(currentWeather: currentWeather)
        
        //        let urlString = "https://api.darksky.net/forecast/4479b07876e9f9b8f4f3d908faa1111c/37.8267,-122.4233"
        //
        //        let baseURL = URL(string: "https://api.darksky.net/forecast/4479b07876e9f9b8f4f3d908faa1111c/")
        //        let fullURL = URL(string: "37.8267,-122.4233", relativeTo: baseURL)
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let userLocation = locations.last! as CLLocation
        
        print("My location latitude: \(userLocation.coordinate.latitude), longitude: \(userLocation.coordinate.longitude)")
        
    }
    
    func getCurrentWeatherData() {
        weatherManager.fetchCurrentWeatherWith(coordinates: coordinates) { (result) in
            self.toggleActivityindicator(on: false)
            switch result {
            case .Success(let currentWeather):
                self.updateUIWith(currentWeather: currentWeather)
            case .Failure(let error as NSError):
                
                let alertController = UIAlertController(title: "Unable to get data ", message: "\(error.localizedDescription)", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                alertController.addAction(okAction)
                
                self.present(alertController, animated: true, completion: nil)
            default: break
            }
        }
    }
    
    func updateUIWith(currentWeather: CurrentWeather) {
        
        self.pressureLbl.text = currentWeather.pressureString
        self.humidityLbl.text = currentWeather.humidityString
        self.temperatureLbl.text = currentWeather.tempString
        self.appearentTempLbl.text = currentWeather.appearentTempString
        self.imageView.image = currentWeather.icon
        
    }
    
    
    
}

