//
//  RemoteWeatherLoaderTests.swift
//  RandomWeatherTests
//
//  Created by Said Rehouni on 30/7/21.
//

import XCTest

struct Weather {}

enum HTTPClientResult {
    case success(Data, HTTPURLResponse)
    case failure(Error)
}

protocol HTTPClient {
    func get(url: URL, completion: @escaping (HTTPClientResult) -> Void)
}

protocol RemoteWeatherLoaderMapper {
    func map(_ data: Data, from response: HTTPURLResponse) -> Weather?
}

class RemoteWeatherLoader {
    let url: URL
    let client: HTTPClient
    let mapper: RemoteWeatherLoaderMapper
    
    enum Result {
        case success(Weather)
        case failure(Error)
    }
    
    enum Error {
        case connectivity
        case serverError
        case invalidData
    }

    init(url: URL, client: HTTPClient, mapper: RemoteWeatherLoaderMapper) {
        self.url = url
        self.client = client
        self.mapper = mapper
    }
    
    func loadWeather(completion: @escaping (Result) -> Void) {
        client.get(url: url) { [weak self] result in
            switch result {
                case let .success(data, response):
                    if self?.isAValidStatusCode(code: response.statusCode) == true {
                        guard let weather = self?.mapper.map(data, from: response) else {
                            completion(.failure(.invalidData))
                            return
                        }
                        completion(.success(weather))
                    } else {
                        completion(.failure(.serverError))
                    }
                    
                    break
                case .failure:
                    completion(.failure(.connectivity))
                    break
            }
        }
    }
    
    private func isAValidStatusCode(code: Int) -> Bool {
        return code == 200
    }
}

class RemoteWeatherLoaderTests: XCTestCase {
    
    func test_loadWeatherDeliversConnectivityError() {
        let (client, _, sut) = makeSUT()
        
        var capturedError: RemoteWeatherLoader.Error?
        client.result = .failure(NSError(domain: "an error", code: 0, userInfo: nil))
        
        sut.loadWeather { result in
            switch result {
            case let .failure(error):
                capturedError = error
            default:
                break
            }
        }
        
        XCTAssertEqual(capturedError, .connectivity)
    }
    
    func test_loadWeatherDeliversWeather() {
        let url = URL(string: "https://google.com")!
        let (client, mapper, sut) = makeSUT(url: url)
        
        client.result = .success(Data(), HTTPURLResponse(url: url,
                                                         statusCode: 200,
                                                         httpVersion: nil,
                                                         headerFields: nil)!)
        mapper.weather = Weather()
        var capturedWeather: Weather?
        
        sut.loadWeather { result in
            switch result {
            case let .success(weather):
                capturedWeather = weather
            default:
                break
            }
        }
        
        XCTAssertNotNil(capturedWeather)
    }
    
    func test_loadWeatherDeliversNon200HTTPStatusCode() {
        let url = URL(string: "https://google.com")!
        let (client, _, sut) = makeSUT(url: url)
        
        client.result = .success(Data(), HTTPURLResponse(url: url,
                                                         statusCode: 300,
                                                         httpVersion: nil,
                                                         headerFields: nil)!)
        var capturedError: RemoteWeatherLoader.Error?
        
        sut.loadWeather { result in
            switch result {
            case let .failure(error):
                capturedError = error
            default:
                break
            }
        }
        
        XCTAssertEqual(capturedError, .serverError)
    }
    
    func test_loadWeatherDeliversInvalidData() {
        let url = URL(string: "https://google.com")!
        let (client, _, sut) = makeSUT(url: url)
        
        client.result = .success(Data(), HTTPURLResponse(url: url,
                                                         statusCode: 200,
                                                         httpVersion: nil,
                                                         headerFields: nil)!)
        
        var capturedError: RemoteWeatherLoader.Error?
        
        sut.loadWeather { result in
            switch result {
            case let .failure(error):
                capturedError = error
            default:
                break
            }
        }
        
        XCTAssertEqual(capturedError, .invalidData)
    }

    //MARK: Helpers
    
    private func makeSUT(url: URL = URL(string: "https://google.com")!) -> (client: HTTPClientSpy, mapper: RemoteWeatherLoaderMapperSpy, sut: RemoteWeatherLoader) {
        let client = HTTPClientSpy()
        let mapper = RemoteWeatherLoaderMapperSpy()
        let sut = RemoteWeatherLoader(url: url, client: client, mapper: mapper)
        
        return (client: client, mapper: mapper, sut: sut)
    }
    
    private class HTTPClientSpy: HTTPClient {
        var result: HTTPClientResult?
        
        func get(url: URL, completion: @escaping (HTTPClientResult) -> Void) {
            if let result = result {
                completion(result)
            }
        }
    }
    
    private class RemoteWeatherLoaderMapperSpy: RemoteWeatherLoaderMapper {
        var weather: Weather?
        
        func map(_ data: Data, from response: HTTPURLResponse) -> Weather? {
            guard let weather = weather else {
                return nil
            }
            return weather
        }
    }

}
