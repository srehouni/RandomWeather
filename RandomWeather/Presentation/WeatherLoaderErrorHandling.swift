//
//  WeatherLoaderErrorHandling.swift
//  RandomWeather
//
//  Created by Said Rehouni on 2/8/21.
//

import Foundation

public protocol WeatherLoaderErrorHandling {
    func getPresentableError(error: Error) -> String
}
