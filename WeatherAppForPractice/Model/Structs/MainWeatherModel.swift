//
//  MainWeatherModel.swift
//  WeatherAppForPractice
//
//  Created by Alex on 21.06.2022.
//

import Foundation

struct MainWeatherModel: Codable {
    var data: [MainData]
}

struct MainData: Codable {
    var timestamp_local: String
    var app_temp: Double
    var weather: MainIconWeather
}

struct MainIconWeather: Codable {
    var icon: String
}
