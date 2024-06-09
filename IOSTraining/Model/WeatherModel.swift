//
//  WeatherModel.swift
//  IOSTraining
//  
//  
//

import Foundation
import UIKit

struct WeatherModel {
    let type: String

    var color: UIColor {
        switch type {
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
