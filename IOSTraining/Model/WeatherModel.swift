//
//  WeatherModel.swift
//  IOSTraining
//  
//  
//

import Foundation
import UIKit

struct WeatherModel {
    let condition: String
    let maxTemperature: Int
    let minTemperature: Int

    var color: UIColor {
        switch condition {
        case "sunny":
            return UIColor.systemRed
        case "cloudy":
            return UIColor.systemGray
        case "rainy":
            return UIColor.systemBlue
        default:
            return UIColor.systemBackground
        }
    }
}
