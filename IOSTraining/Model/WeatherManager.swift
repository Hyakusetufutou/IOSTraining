//
//  WeatherManager.swift
//  IOSTraining
//  
//  
//

import Foundation
import YumemiWeather

protocol WeatherManagerDelegate {
    func weatherImageDidUpdate(weatherModel: WeatherModel)
}

struct WeatherManager {
    var delegate: WeatherManagerDelegate?

    func fetchWeatherCondition() {
        let weatherType = YumemiWeather.fetchWeatherCondition()
        let weatherModel = WeatherModel(type: weatherType)
        delegate?.weatherImageDidUpdate(weatherModel: weatherModel)
    }
}
