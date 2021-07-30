//
//  ViewController.swift
//  RandomWeather
//
//  Created by Said Rehouni on 30/7/21.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}
/*
struct Weather {
    
}
private struct RemoteWeather: Decodable {
    let id: UUID
    let description: String?
    let location: String?
    let image: URL
}

extension RemoteWeather {
    func toDomain() -> Weather {
        Weather()
    }
}

public final class FeedItemsMapper {
    
    public enum Error: Swift.Error {
        case invalidData
    }
    
    public static func map(_ data: Data, from response: HTTPURLResponse) throws -> Weather {
        guard response.isOK, let weather = try? JSONDecoder().decode(RemoteWeather.self, from: data) else {
            throw Error.invalidData
        }
        
        return weather.toDomain()
    }
}

enum HTTPClientResult {
    case success(Data, HTTPURLResponse)
    case failure(Error)
}

protocol HTTPClient {
    func get(url: URL, completion: @escaping (HTTPClientResult) -> Void)
}

class HTTPClientSpy: HTTPClient {
    func get(url: URL, completion: @escaping (HTTPClientResult) -> Void) {
        
    }
}

class RemoteWeatherLoader {
    let url: URL
    let client: HTTPClient
    let mapper: FeedItemsMapper
    
    enum Result {
        case success(Weather)
        case failure(Error)
    }
    
    enum Error: Swift.Error {
        case connectivity
        case invalidaData
    }
    
    init(url: URL, client: HTTPClient, mapper: FeedItemsMapper) {
        self.url = url
        self.client = client
        self.mapper = mapper
    }
    
    func loadWeather(completion: @escaping (Result) -> Void) {
        client.get(url: url) { result in
            switch result {
                
            }
            
        }
    }
}
*/
