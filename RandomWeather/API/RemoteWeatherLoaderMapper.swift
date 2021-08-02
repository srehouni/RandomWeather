//
//  RemoteWeatherLoaderMapper.swift
//  RandomWeather
//
//  Created by Said Rehouni on 2/8/21.
//

import Foundation

public class RemoteWeatherLoaderMapper: RemoteWeatherLoaderMapperProtocol {
    public init() {}
    
    public func map(_ data: Data, from response: HTTPURLResponse) -> Weather? {
        return try? JSONDecoder().decode(RemoteWeather.self, from: data).toDomain()
    }
}
