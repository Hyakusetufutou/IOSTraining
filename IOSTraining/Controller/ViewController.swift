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
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var minTemperatureLabel: UILabel!
    @IBOutlet weak var maxTemperatureLabel: UILabel!
    
    var weatherManager = WeatherManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        weatherManager.delegate = self
    }

    @IBAction func reloadButtonPressed(_ sender: UIButton) {
        weatherManager.fetchWeatherData()
    }
    
    @IBAction func closeButtonPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension ViewController: WeatherManagerDelegate {
    func weatherImageDidUpdate(weatherModel: WeatherModel) {
        DispatchQueue.main.async {
            self.weatherImage.image = UIImage(named: weatherModel.condition)
            self.weatherImage.tintColor = weatherModel.color
            self.minTemperatureLabel.text = String(weatherModel.minTemperature)
            self.maxTemperatureLabel.text = String(weatherModel.maxTemperature)
        }
    }

    func showFetchWeatherDataError() {
        let alert = UIAlertController(title: "Error", message: "天気データの取得に失敗しました", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default))
        self.present(alert, animated: true, completion: nil)
    }
}

