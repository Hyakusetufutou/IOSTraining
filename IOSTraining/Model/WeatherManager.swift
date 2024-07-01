//
//  WeatherManager.swift
//  IOSTraining
//  
//  
//

import Foundation
import YumemiWeather

protocol WeatherManagerDelegate: AnyObject {
    func weatherImageDidUpdate(weatherModel: WeatherModel)
    func showFetchWeatherDataError()
}

protocol WeatherFetching {
    var delegate: WeatherManagerDelegate? { get set }
    func fetchWeatherData()
}

struct WeatherManager: WeatherFetching {
    weak var delegate: WeatherManagerDelegate?

    func fetchWeatherData() {
        DispatchQueue.global().async {
            do {
                let request = WeatherDataRequest(area: "tokyo", date: Date().formatted(Date.ISO8601FormatStyle().dateSeparator(.dash)))
                if let jsonString = makeJSON(request: request) {
                    let response = try YumemiWeather.syncFetchWeather(jsonString)
                    let weatherModel = self.parseJSON(response: response)
                    if let safeWeatherModel = weatherModel {
                        self.delegate?.weatherImageDidUpdate(weatherModel: safeWeatherModel)
                    }
                }
            } catch {
                self.delegate?.showFetchWeatherDataError()
            }
        }
    }

    private func makeJSON(request: WeatherDataRequest) -> String? {
        var jsonString: String?
        let encoder = JSONEncoder()
        encoder.outputFormatting = [.prettyPrinted, .withoutEscapingSlashes]

        do {
            let jsonData = try encoder.encode(request)
            jsonString = String(data: jsonData, encoding: .utf8)
        } catch {
            self.delegate?.showFetchWeatherDataError()
        }

        return jsonString
    }

    private func parseJSON(response: String) -> WeatherModel? {
        var weatherModel: WeatherModel?
        let decoder = JSONDecoder()

        do {
            if let responseData = response.data(using: .utf8) {
                let decodeData = try decoder.decode(WeatherDataResponse.self, from: responseData)
                let condition = decodeData.weather_condition
                let maxTemperature = decodeData.max_temperature
                let minTemperature = decodeData.min_temperature
                weatherModel = WeatherModel(condition: condition, maxTemperature: maxTemperature, minTemperature: minTemperature)
            }
        } catch {
            self.delegate?.showFetchWeatherDataError()
        }

        return weatherModel
    }
}
