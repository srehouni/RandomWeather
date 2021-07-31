//
//  WeatherLoader.swift
//  RandomWeather
//
//  Created by Said Rehouni on 31/7/21.
//

import Foundation

public protocol WeatherLoader {
    typealias Result = Swift.Result<Weather, Error>
    func loadWeather(completion: @escaping (Result) -> Void)
}
