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
    let temperature: Int
    let feelsLike: Int
    let minTemperature: Int
    let maxTemperature: Int
    let pressure: Int
    let humidity: Int
    let wind: Float
    
    public init(description: String, temperature: Int, feelsLike: Int, minTemperature: Int, maxTemperature: Int, pressure: Int, humidity: Int, wind: Float) {
        self.description = description
        self.temperature = temperature
        self.feelsLike = feelsLike
        self.minTemperature = minTemperature
        self.maxTemperature = maxTemperature
        self.pressure = pressure
        self.humidity = humidity
        self.wind = wind
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

extension Weather: Equatable {
    public static func == (lhs: Weather, rhs: Weather) -> Bool {
        return lhs.city.name == rhs.city.name
            && lhs.stats.temperature == rhs.stats.temperature
            && lhs.stats.description == rhs.stats.description
            && lhs.stats.temperature == rhs.stats.temperature
            && lhs.stats.feelsLike == rhs.stats.feelsLike
            && lhs.stats.minTemperature == rhs.stats.minTemperature
            && lhs.stats.maxTemperature == rhs.stats.maxTemperature
            && lhs.stats.pressure == rhs.stats.pressure
            && lhs.stats.humidity == rhs.stats.humidity
            && lhs.stats.wind == rhs.stats.wind
    }
}
