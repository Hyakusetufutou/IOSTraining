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
    func showFetchWeatherDataError()
}

struct WeatherManager {
    var delegate: WeatherManagerDelegate?

    func fetchWeatherCondition() {
        do {
            let weatherType = try YumemiWeather.fetchWeatherCondition(at: "tokyo")
            let weatherModel = WeatherModel(type: weatherType)
            delegate?.weatherImageDidUpdate(weatherModel: weatherModel)
        } catch {
            self.delegate?.showFetchWeatherDataError()
        }
    }
}
