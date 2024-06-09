//
//  ViewController.swift
//  
//  
//  
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var reloadButton: UIButton!
    
    var weatherManager = WeatherManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        weatherManager.delegate = self
    }

    @IBAction func reloadButtonPressed(_ sender: UIButton) {
        weatherManager.fetchWeatherCondition()
    }
    
}

extension ViewController: WeatherManagerDelegate {
    func weatherImageDidUpdate(weatherModel: WeatherModel) {
        self.weatherImage.image = UIImage(named: weatherModel.type)
        weatherImage.tintColor = weatherModel.color
    }
}

