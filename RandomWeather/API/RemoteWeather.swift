//
//  RemoteWeather.swift
//  RandomWeather
//
//  Created by Said Rehouni on 2/8/21.
//

import Foundation

struct RemoteWeather: Decodable {
    let coord: RemoteLocation
    let weather: [RemoteWeatherInfo]
    let main: RemoteWeatherStats
    let wind: RemoteWeatherWind
    let sys: RemoteSys
    let name: String
}

extension RemoteWeather {
    func toDomain() -> Weather {
        return Weather(city: City(name: name,
                                  location: Location(latitude: coord.latitude,
                                                     longitude: coord.longitude)),
                       stats: WeatherStats(description: weather.first?.main.description ?? "",
                                           temperature: main.temp,
                                           feelsLike: main.feelsLike,
                                           minTemperature: main.tempMin,
                                           maxTemperature: main.tempMax,
                                           pressure: main.pressure,
                                           humidity: main.humidity))
    }
}

struct RemoteWeatherStats: Decodable {
    let temp: Float
    let feelsLike: Float
    let tempMin: Float
    let tempMax: Float
    let pressure: Int
    let humidity: Int
    
    enum CodingKeys: String, CodingKey {
        case temp, pressure, humidity
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
    }
}

struct RemoteWeatherInfo: Decodable {
    let main: String
    let description: String?
}

struct RemoteWeatherWind: Decodable {
    let speed: Float
    let deg: Float
}

struct RemoteLocation: Decodable {
    let longitude: Float
    let latitude: Float
    
    enum CodingKeys: String, CodingKey {
        case longitude = "lon"
        case latitude = "lat"
    }
}

struct RemoteSys: Decodable {
    let sunrise: Double
    let sunset: Double
}
