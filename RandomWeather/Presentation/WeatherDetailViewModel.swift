//
//  WeatherDetailViewModel.swift
//  RandomWeather
//
//  Created by Said Rehouni on 2/8/21.
//

import Foundation

public class WeatherDetailViewModel {
    public var shouldPresentErrorMessage: String?
    private let weatherLoader: WeatherLoader
    
    public var cityName: String?
    public var description: String?
    public var temperature: String?
    public var feelsLike: String?
    public var minTemperature: String?
    public var maxTemperature: String?
    public var pressure: String?
    public var humidity: String?
    
    public init(weatherLoader: WeatherLoader) {
        self.weatherLoader = weatherLoader
    }
    
    public func loadWeather() {
        weatherLoader.loadWeather { [weak self] result in
            switch result {
            case let .success(weather):
                self?.updateData(weather: weather)
            case let .failure(error):
                self?.handleError(error: error)
            }
        }
    }
    
    private func handleError(error: Error) {
        shouldPresentErrorMessage = "Error"
    }
    
    private func updateData(weather: Weather) {
        cityName = weather.city.name
        description = weather.stats.description
        temperature = "\(weather.stats.temperature)"
        feelsLike = "\(weather.stats.feelsLike)"
        minTemperature = "\(weather.stats.minTemperature)"
        maxTemperature = "\(weather.stats.maxTemperature)"
        pressure = "\(weather.stats.pressure)"
        humidity = "\(weather.stats.humidity)"
    }
}
