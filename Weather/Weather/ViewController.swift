//
//  ViewController.swift
//  Weather
//
//  Created by Medi Assumani on 8/4/19.
//  Copyright © 2019 Medi Assumani. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchWeather()
    }


    func fetchWeather(){
        
        WeatherService.shared.getForecastBy(city: "London") { (result) in
            print("hi")
        }
    }
}

struct WeatherService {
    
    static let shared = WeatherService()
    let weatherSession = URLSession(configuration: .default)
    
    func getForecastBy(city: String, completion: @escaping((Result<Weather, Error>) -> ())) {
        
        let api_key = "8f7fa07c721b55e88e1d8383f84ad84b"
        var baseURLString = "https://api.openweathermap.org/data/2.5/weather?q=London&appid=\(api_key)"
        var url = URL(string: baseURLString)
        var req = URLRequest(url: url!)
    
        weatherSession.dataTask(with: req) { (data, res, err) in
            
            if (err == nil){
                
                guard let unwrappedData = data else { return }
                do {
                    var result = try JSONDecoder().decode(Weather.self, from: unwrappedData)
                    print(result)
                } catch {
                    print("decoding error")
                }
            }
        }.resume()
    }
}
struct Weather: Decodable {
    
    var main: Temperature
    var name: String
}

struct Temperature: Decodable {
    
    var temp: Double
}
