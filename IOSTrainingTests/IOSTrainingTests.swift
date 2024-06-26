//
//  IOSTrainingTests.swift
//  IOSTrainingTests
//  
//  
//

import XCTest
@testable import IOSTraining

final class IOSTrainingTests: XCTestCase {

    var viewController: ViewController!
    var mockWeatherFetching: MockWeatherFetching!

    override func setUpWithError() throws {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        mockWeatherFetching = MockWeatherFetching()
        viewController = storyboard.instantiateViewController(identifier: "ViewController") { coder in
            ViewController(coder: coder, weatherFetching: self.mockWeatherFetching)
        }

        viewController.loadViewIfNeeded()
    }

    override func tearDownWithError() throws {
        viewController = nil
        mockWeatherFetching = nil
    }


    func testReloadButtonPressedCallsFetchWeatherData() {
        viewController.reloadButtonPressed(viewController.reloadButton)
        XCTAssertTrue(mockWeatherFetching.fetchWeatherDataCalled)
    }

    func testAppWillBecomeActiveCallsFetchWeatherData() {
        NotificationCenter.default.post(name: UIApplication.didBecomeActiveNotification, object: nil)
        XCTAssertTrue(mockWeatherFetching.fetchWeatherDataCalled)
    }

    func testWeatherImageDidUpdateUpdatesUI() {
        let weatherModel = WeatherModel(condition: "cloudy", maxTemperature: 20, minTemperature: 5)
        viewController.weatherImageDidUpdate(weatherModel: weatherModel)

        // メインスレッドでの更新を確認するために期待されるUI状態を待つ
        let expectation = XCTestExpectation(description: "UI should be updated")

        DispatchQueue.main.async {
            XCTAssertEqual(self.viewController.weatherImage.image, UIImage(named: "cloudy"))
            XCTAssertEqual(self.viewController.minTemperatureLabel.text, "5")
            XCTAssertEqual(self.viewController.maxTemperatureLabel.text, "20")
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 1.0)
    }
}

class MockWeatherFetching: WeatherFetching {
    var delegate: WeatherManagerDelegate?
    var fetchWeatherDataCalled = false

    func fetchWeatherData() {
        fetchWeatherDataCalled = true
        let weatherModel = WeatherModel(condition: "sunny", maxTemperature: 30, minTemperature: 10)
        delegate?.weatherImageDidUpdate(weatherModel: weatherModel)
    }
}
