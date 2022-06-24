//
//  HeaderWeatherModel.swift
//  WeatherAppForPractice
//
//  Created by Alex on 20.06.2022.
//

import Foundation

struct HeaderWeatherModel: Codable {
    var data: [HeaderData]
    var city_name: String
}

struct HeaderData: Codable {
    var temp: Double
}
