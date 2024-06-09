//
//  WeatherData.swift
//  IOSTraining
//  
//  
//

import Foundation

struct WeatherDataRequest: Codable {
    let area: String
    let date: String
}

struct WeatherDataResponse: Codable {
    let max_temperature: Int
    let date: String
    let min_temperature: Int
    let weather_condition: String
}
