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
        case serverError
    }

    init(url: URL, client: HTTPClient) {
        self.url = url
        self.client = client
    }
    
    func loadWeather(completion: @escaping (Result) -> Void) {
        client.get(url: url) { [weak self] result in
            switch result {
                case let .success(_, response):
                    if self?.isAValidStatusCode(code: response.statusCode) == true {
                        completion(.success(Weather()))
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
    
    func test_loadWeatherDeliversNon200HTTPStatusCode() {
        let url = URL(string: "https://google.com")!
        let client = HTTPClientSpy()
        let sut = RemoteWeatherLoader(url: url, client: client)
        
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
