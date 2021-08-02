//
//  WeatherDetailViewModel.swift
//  RandomWeather
//
//  Created by Said Rehouni on 2/8/21.
//

import Foundation
import RxSwift

public final class WeatherDetailViewModel: ViewModelType {
    private let weatherLoader: WeatherLoader
    private let weatherLoaderErrorHandling: WeatherLoaderErrorHandling
    
    private var showLoading = BehaviorSubject<Bool>(value: false)
    public var shouldPresentLoading: Observable<Bool> {
        return showLoading.map { $0 }
    }
    
    private var errorMessage = BehaviorSubject<String?>(value: nil)
    public var shouldPresentErrorMessage: Observable<String?> {
        return errorMessage.map { $0 }
    }
    
    private let cityName = BehaviorSubject<String?>(value: nil)
    public var cityNameObservable: Observable<String?> {
        return cityName.map { $0 }
    }
    
    private let description = BehaviorSubject<String?>(value: nil)
    public var descriptionObservable: Observable<String?> {
        return description.map { $0 }
    }
    
    private let temperature = BehaviorSubject<String?>(value: nil)
    public var temperatureObservable: Observable<String?> {
        return temperature.map { $0 }
    }
    
    private let feelsLike = BehaviorSubject<String?>(value: nil)
    public var feelsLikeObservable: Observable<String?> {
        return feelsLike.map { $0 }
    }
    
    private let minTemperature = BehaviorSubject<String?>(value: nil)
    public var minTemperatureObservable: Observable<String?> {
        return minTemperature.map { $0 }
    }
    
    private let maxTemperature = BehaviorSubject<String?>(value: nil)
    public var maxTemperatureObservable: Observable<String?> {
        return maxTemperature.map { $0 }
    }
    
    private let pressure = BehaviorSubject<String?>(value: nil)
    public var pressureObservable: Observable<String?> {
        return pressure.map { $0 }
    }
    
    private let humidity = BehaviorSubject<String?>(value: nil)
    public var humidityObservable: Observable<String?> {
        return humidity.map { $0 }
    }
    
    private let wind = BehaviorSubject<String?>(value: nil)
    public var windObservable: Observable<String?> {
        return wind.map { $0 }
    }
    
    public init(weatherLoader: WeatherLoader, weatherLoaderErrorHandling: WeatherLoaderErrorHandling) {
        self.weatherLoader = weatherLoader
        self.weatherLoaderErrorHandling = weatherLoaderErrorHandling
    }
    
    public func loadWeather() {
        showLoading.onNext(true)
        weatherLoader.loadWeather { [weak self] result in
            self?.showLoading.onNext(false)
            switch result {
            case let .success(weather):
                self?.updateData(weather: weather)
            case let .failure(error):
                self?.handleError(error: error)
            }
        }
    }
    
    private func handleError(error: Error) {
        errorMessage.onNext(weatherLoaderErrorHandling.getPresentableError(error: error))
    }
    
    private func updateData(weather: Weather) {
        if weather.city.name.isEmpty {
            cityName.onNext("\(weather.city.location.longitude), \(weather.city.location.latitude)")
        } else {
            cityName.onNext(weather.city.name)
        }
        
        description.onNext(weather.stats.description)
        temperature.onNext("\(weather.stats.temperature)º")
        feelsLike.onNext("\(weather.stats.feelsLike)º")
        minTemperature.onNext("Min \(weather.stats.minTemperature)º")
        maxTemperature.onNext("Máx \(weather.stats.maxTemperature)º")
        pressure.onNext("\(weather.stats.pressure) hPa")
        humidity.onNext("\(weather.stats.humidity)%")
        wind.onNext("\(weather.stats.wind)km/h")
    }
}
