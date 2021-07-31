//
//  Weather.swift
//  RandomWeather
//
//  Created by Said Rehouni on 31/7/21.
//

import Foundation

public struct Weather {
    let city: City
    let stats: WeatherStats
    
    public init(city: City, stats: WeatherStats) {
        self.city = city
        self.stats = stats
    }
}

public struct WeatherStats {
    let description: String
    let temperature: Float
    let feelsLike: Float
    let minTemperature: Float
    let maxTemperature: Float
    let pressure: Int
    let humidity: Int
    
    public init(description: String, temperature: Float, feelsLike: Float, minTemperature: Float, maxTemperature: Float, pressure: Int, humidity: Int) {
        self.description = description
        self.temperature = temperature
        self.feelsLike = feelsLike
        self.minTemperature = minTemperature
        self.maxTemperature = maxTemperature
        self.pressure = pressure
        self.humidity = humidity
    }
}

public struct City {
    let name: String
    let location: Location
    
    public init(name: String, location: Location) {
        self.name = name
        self.location = location
    }
}

public struct Location {
    let latitude: Float
    let longitude: Float
    
    public init(latitude: Float, longitude: Float) {
        self.latitude = latitude
        self.longitude = longitude
    }
}
