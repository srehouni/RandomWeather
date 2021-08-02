//
//  WeatherDetailViewModelTests.swift
//  RandomWeatherTests
//
//  Created by Said Rehouni on 2/8/21.
//

import XCTest
import RandomWeather

class WeatherLoaderSpy: WeatherLoader {
    var result: WeatherLoader.Result?
    
    func loadWeather(completion: @escaping (WeatherLoader.Result) -> Void) {
        if let result = result {
            completion(result)
        }
    }
}

class WeatherDetailViewModelTests: XCTestCase {

    func test_triesToLoadWeatherAndFails() {
        let weatherLoader = WeatherLoaderSpy()
        let viewModel = WeatherDetailViewModel(weatherLoader: weatherLoader)
        
        weatherLoader.result = .failure(NSError(domain: "An error", code: 0, userInfo: nil))
        
        viewModel.loadWeather()
        
        XCTAssertNotNil(viewModel.shouldPresentErrorMessage)
    }
    
    func test_triesToLoadWeatherAndSucceeds() {
        let weatherLoader = WeatherLoaderSpy()
        let viewModel = WeatherDetailViewModel(weatherLoader: weatherLoader)
        
        weatherLoader.result = .success(createRandomWeather())
        
        viewModel.loadWeather()
        
        XCTAssertEqual(viewModel.cityName, "Shuzenji")
        XCTAssertEqual(viewModel.description, "Clear")
        XCTAssertEqual(viewModel.temperature, "281.52")
        XCTAssertEqual(viewModel.feelsLike, "278.99")
        XCTAssertEqual(viewModel.minTemperature, "280.15")
        XCTAssertEqual(viewModel.maxTemperature, "283.71")
        XCTAssertEqual(viewModel.pressure, "1016")
        XCTAssertEqual(viewModel.humidity, "93")
    }
    
    //MARK: - Helpers
    
    private func createRandomWeather() -> Weather {
        return Weather(city: City(name: "Shuzenji",
                        location: Location(latitude: 35,
                                              longitude: 139)),
                stats: WeatherStats(description: "Clear",
                                    temperature: 281.52,
                                    feelsLike: 278.99,
                                    minTemperature: 280.15,
                                    maxTemperature: 283.71,
                                    pressure: 1016,
                                    humidity: 93))
    }

}
