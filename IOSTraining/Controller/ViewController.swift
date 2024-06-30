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
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var weatherFetching: WeatherFetching

    static func getInstance(weatherFetching: WeatherFetching) -> ViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(identifier: "ViewController") { coder in
            ViewController(coder: coder, weatherFetching: weatherFetching)
        }

        return viewController
    }

    init?(coder: NSCoder, weatherFetching: WeatherFetching) {
        self.weatherFetching = weatherFetching
        super.init(coder: coder)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        weatherFetching.delegate = self

        NotificationCenter.default.addObserver(self, selector: #selector(appWillBecomeActive), name: UIApplication.didBecomeActiveNotification, object: nil)
        activityIndicator.hidesWhenStopped = true
    }

    @IBAction func reloadButtonPressed(_ sender: UIButton) {
        DispatchQueue.main.async {
            self.activityIndicator.startAnimating()
        }
        weatherFetching.fetchWeatherData()
    }
    
    @IBAction func closeButtonPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }

    @objc func appWillBecomeActive(_ notification: Notification) {
        print("test")
        weatherFetching.fetchWeatherData()
    }
}

extension ViewController: WeatherManagerDelegate {
    func weatherImageDidUpdate(weatherModel: WeatherModel) {
        DispatchQueue.main.async {
            self.weatherImage.image = UIImage(named: weatherModel.condition)
            self.weatherImage.tintColor = weatherModel.color
            self.minTemperatureLabel.text = String(weatherModel.minTemperature)
            self.maxTemperatureLabel.text = String(weatherModel.maxTemperature)
            self.activityIndicator.stopAnimating()
        }
    }

    func showFetchWeatherDataError() {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Error", message: "天気データの取得に失敗しました", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default))
            self.present(alert, animated: true, completion: nil)
            self.activityIndicator.stopAnimating()
        }
    }
}

