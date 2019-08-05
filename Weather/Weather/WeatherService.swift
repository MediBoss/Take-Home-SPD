//
//  WeatherService.swift
//  Weather
//
//  Created by Medi Assumani on 8/4/19.
//  Copyright © 2019 Medi Assumani. All rights reserved.
//

import Foundation

struct WeatherService {
    
    static let shared = WeatherService()
    let weatherSession = URLSession(configuration: .default)
    
    func getForecastBy(lon: Double, lat: Double, completion: @escaping((Result<Weather, Error>) -> ())) {
        
        let api_key = "8f7fa07c721b55e88e1d8383f84ad84b"
        let baseURLString = "https://api.openweathermap.org/data/2.5/weather?lat=\(lat)&lon=\(lon)&appid=\(api_key)"
        let url = URL(string: baseURLString)
        let req = URLRequest(url: url!)
        
        weatherSession.dataTask(with: req) { (data, res, err) in
            
            if (err == nil){
                
                guard let unwrappedData = data else { return }
                do {
                    let result = try JSONDecoder().decode(Weather.self, from: unwrappedData)
                    completion(.success(result))
                } catch {
                    completion(.failure(err!))
                }
            }
            }.resume()
    }
}
