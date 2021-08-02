//
//  RemoteWeatherLoaderErrorHandling.swift
//  RandomWeather
//
//  Created by Said Rehouni on 2/8/21.
//

import Foundation

public class RemoteWeatherLoaderErrorHandling: WeatherLoaderErrorHandling {
    public init() {}
    
    public func getPresentableError(error: Error) -> String {
        switch error {
            case RemoteWeatherLoader.Error.connectivity:
                return ""
            case RemoteWeatherLoader.Error.invalidData:
                return ""
            case RemoteWeatherLoader.Error.invalidURL:
                return ""
            case RemoteWeatherLoader.Error.serverError:
                return ""
            default:
                return ""
        }
    }
}
