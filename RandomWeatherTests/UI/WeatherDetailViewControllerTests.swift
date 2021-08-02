//
//  WeatherDetailViewControllerTests.swift
//  RandomWeatherTests
//
//  Created by Said Rehouni on 2/8/21.
//

import XCTest
import RandomWeather

class WeatherDetailViewControllerTests: XCTestCase {

    func test_triesToLoadWeatherAndSucceeds() {
        let weatherLoader = WeatherLoaderSpy()
        let viewModel = WeatherDetailViewModel(weatherLoader: weatherLoader,
                                               weatherLoaderErrorHandling: RemoteWeatherLoaderErrorHandling())
        let viewController: WeatherDetailViewController = WeatherDetailViewController.create(viewModel: viewModel)
        
        let weather = createRandomWeather()
        weatherLoader.result = .success(weather)
        
        _ = viewController.view
        
        XCTAssertEqual(viewController.cityName, "Shuzenji")
        XCTAssertEqual(viewController.weatherDescription, "Clear")
        XCTAssertEqual(viewController.temperature, "23º")
        XCTAssertEqual(viewController.feelsLike, "23º")
        XCTAssertEqual(viewController.minTemperature, "Min 19º")
        XCTAssertEqual(viewController.maxTemperature, "Máx 25º")
        XCTAssertEqual(viewController.pressure, "1016 hPa")
        XCTAssertEqual(viewController.humidity, "93%")
        XCTAssertEqual(viewController.wind, "7.8km/h")
    }
}
