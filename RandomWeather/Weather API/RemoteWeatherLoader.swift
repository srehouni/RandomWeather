//
//  RemoteWeatherLoader.swift
//  RandomWeather
//
//  Created by Said Rehouni on 31/7/21.
//

import Foundation

public protocol RemoteWeatherLoaderMapper {
    func map(_ data: Data, from response: HTTPURLResponse) -> Weather?
}

public final class RemoteWeatherLoader: WeatherLoader {
    let url: URL
    let client: HTTPClient
    let mapper: RemoteWeatherLoaderMapper
    
    public enum Error: Swift.Error {
        case connectivity
        case serverError
        case invalidData
    }

    public init(url: URL, client: HTTPClient, mapper: RemoteWeatherLoaderMapper) {
        self.url = url
        self.client = client
        self.mapper = mapper
    }
    
    public func loadWeather(completion: @escaping (WeatherLoader.Result) -> Void) {
        client.get(url: url) { [weak self] result in
            switch result {
                case let .success(data, response):
                    if self?.isAValidStatusCode(code: response.statusCode) == true {
                        guard let weather = self?.mapper.map(data, from: response) else {
                            completion(.failure(Error.invalidData))
                            return
                        }
                        completion(.success(weather))
                    } else {
                        completion(.failure(Error.serverError))
                    }
                    
                    break
                case .failure:
                    completion(.failure(Error.connectivity))
                    break
            }
        }
    }
    
    private func isAValidStatusCode(code: Int) -> Bool {
        return code == 200
    }
}
