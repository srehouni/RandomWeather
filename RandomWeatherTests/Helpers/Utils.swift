//
//  Utils.swift
//  RandomWeatherTests
//
//  Created by Said Rehouni on 2/8/21.
//

import Foundation
import RandomWeather

func createRandomWeather() -> Weather {
    return Weather(city: City(name: "Shuzenji",
                    location: Location(latitude: 35,
                                          longitude: 139)),
            stats: WeatherStats(description: "Clear",
                                temperature: 23,
                                feelsLike: 23,
                                minTemperature: 19,
                                maxTemperature: 25,
                                pressure: 1016,
                                humidity: 93,
                                wind: 7.8))
}
