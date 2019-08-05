//
//  ViewController.swift
//  Weather
//
//  Created by Medi Assumani on 8/4/19.
//  Copyright © 2019 Medi Assumani. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    
    @IBOutlet weak var moodEmojiLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var temperatureLbale: UILabel!
    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getUserCoordinates()
        locationManager.delegate = self
    }

    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else {return}
        
        WeatherService.shared.getForecastBy(lon: locValue.longitude, lat: locValue.latitude) { (result) in
            
            switch result {
            case let . success(weather):
                
                let convertedTemperature = Int(round(weather.main.temp * (9/5) - 459.67))
                DispatchQueue.main.async {
                    if (convertedTemperature < 60 && convertedTemperature > 30){
                        self.moodEmojiLabel.text = "😞"
                    } else if (convertedTemperature < 30){
                        self.moodEmojiLabel.text = "🥶"
                    }
                    self.temperatureLbale.text = "\(convertedTemperature)°"
                    self.locationLabel.text = weather.name
                }
                
            case .failure(_):
                print("failled to load weather")
            }
        }
    }
    
    /// Propmt the user to grant access to the device's current location
    private func getUserCoordinates(){
        self.locationManager.requestAlwaysAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
    }
}
