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

class RemoteWeatherLoader {
    let url: URL
    let client: HTTPClient
    
    enum Result {
        case success(Weather)
        case failure(Error)
    }
    
    enum Error {
        case connectivity
    }

    init(url: URL, client: HTTPClient) {
        self.url = url
        self.client = client
    }
    
    func loadWeather(completion: @escaping (Result) -> Void) {
        client.get(url: url) { result in
            switch result {
                case let .success:
                    completion(.success(Weather()))
                    break
                case let .failure:
                    completion(.failure(.connectivity))
                    break
            }
        }
    }
}

class RemoteWeatherLoaderTests: XCTestCase {
    
    func test_loadWeatherDeliversConnectivityError() {
        let client = HTTPClientSpy()
        let sut = RemoteWeatherLoader(url: URL(string: "https://google.com")!, client: client)
        
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
        let client = HTTPClientSpy()
        let sut = RemoteWeatherLoader(url: url, client: client)
        
        client.result = .success(Data(), HTTPURLResponse(url: url,
                                                         statusCode: 200,
                                                         httpVersion: nil,
                                                         headerFields: nil)!)
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

    //MARK: Helpers
    
    private class HTTPClientSpy: HTTPClient {
        var result: HTTPClientResult?
        
        func get(url: URL, completion: @escaping (HTTPClientResult) -> Void) {
            if let result = result {
                completion(result)
            }
        }
    }

}
