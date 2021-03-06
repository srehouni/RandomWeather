//
//  RemoteWeatherLoaderTests.swift
//  RandomWeatherTests
//
//  Created by Said Rehouni on 30/7/21.
//

import XCTest
import RandomWeather

class RemoteWeatherLoaderTests: XCTestCase {
    
    func test_loadWeatherDeliversConnectivityError() {
        let (client, _, sut) = makeSUT()
        
        var capturedError: RemoteWeatherLoader.Error?
        client.result = .failure(NSError(domain: "an error", code: 0, userInfo: nil))
        
        sut.loadWeather { result in
            switch result {
            case let .failure(error):
                capturedError = error as? RemoteWeatherLoader.Error
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
        mapper.weather = createRandomWeather()
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
                capturedError = error as? RemoteWeatherLoader.Error
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
                capturedError = error as? RemoteWeatherLoader.Error
            default:
                break
            }
        }
        
        XCTAssertEqual(capturedError, .invalidData)
    }

    //MARK: - Helpers
    
    private func makeSUT(url: URL = URL(string: "https://google.com")!) -> (client: HTTPClientSpy, mapper: RemoteWeatherLoaderMapperSpy, sut: RemoteWeatherLoader) {
        let client = HTTPClientSpy()
        let mapper = RemoteWeatherLoaderMapperSpy()
        let sut = RemoteWeatherLoader(urlGenerator: RandomURLGeneratorSpy(url: url),
                                      client: client,
                                      mapper:
                                        mapper)
        
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
    
    private class RemoteWeatherLoaderMapperSpy: RemoteWeatherLoaderMapperProtocol {
        var weather: Weather?
        
        func map(_ data: Data, from response: HTTPURLResponse) -> Weather? {
            guard let weather = weather else {
                return nil
            }
            return weather
        }
    }
    
    private class RandomURLGeneratorSpy: URLGenerator {
        let url: URL
        
        init(url: URL) {
            self.url = url
        }
        
        func getURL() -> URL? {
            return url
        }
    }
}
