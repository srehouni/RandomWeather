//
//  WeatherDetailViewModelTests.swift
//  RandomWeatherTests
//
//  Created by Said Rehouni on 2/8/21.
//

import XCTest
import RandomWeather

class WeatherDetailViewModel {
    var shouldPresentErrorMessage: String?
    let weatherLoader: WeatherLoader
    
    init(weatherLoader: WeatherLoader) {
        self.weatherLoader = weatherLoader
    }
    
    func loadWeather() {
        weatherLoader.loadWeather { [weak self] result in
            self?.shouldPresentErrorMessage = "Error"
        }
    }
}

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

}
