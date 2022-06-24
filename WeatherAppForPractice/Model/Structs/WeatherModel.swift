//
//  WatherModel.swift
//  WeatherAppForPractice
//
//  Created by Alex on 20.06.2022.
//

import Foundation

struct WeatherModel: Codable {
    var data: [SomeData]
}

struct SomeData: Codable {
    var max_temp: Double
    var low_temp: Double
    var valid_date: String
    var weather: Weather
}

struct Weather: Codable {
    var icon: String
    var description: String
}
