//
//  Weather.swift
//  Weather
//
//  Created by Medi Assumani on 8/4/19.
//  Copyright © 2019 Medi Assumani. All rights reserved.
//

import Foundation


struct Weather: Decodable {
    
    var main: Temperature
    var name: String
}

struct Temperature: Decodable {
    
    var temp: Double
}
