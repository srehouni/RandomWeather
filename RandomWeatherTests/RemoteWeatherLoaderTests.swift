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
    func get(url: URL, completion: @escaping (Error?) -> Void)
}

class HTTPClientSpy: HTTPClient {
    var error: Error?
    
    func get(url: URL, completion: @escaping (Error?) -> Void) {
        completion(error)
    }
}

class RemoteWeatherLoader {
    let url: URL
    let client: HTTPClient
    
    enum Error {
        case connectivity
    }

    init(url: URL, client: HTTPClient) {
        self.url = url
        self.client = client
    }
    
    func loadWeather(completion: @escaping (Error?) -> Void) {
        client.get(url: url) { error in
            if error != nil {
                completion(.connectivity)
            }
        }
    }
}

class RemoteWeatherLoaderTests: XCTestCase {
    
    func test_loadWeatherDeliversConnectivityError() {
        let client = HTTPClientSpy()
        let sut = RemoteWeatherLoader(url: URL(string: "https://google.com")!, client: client)
        
        var capturedError: RemoteWeatherLoader.Error?
        client.error = NSError(domain: "an error", code: 0, userInfo: nil)
        
        sut.loadWeather { result in
            capturedError = result
        }
        
        XCTAssertEqual(capturedError, .connectivity)
    }

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
