//
//  URLSessionHTTPClient.swift
//  RandomWeather
//
//  Created by Said Rehouni on 2/8/21.
//

import Foundation

class URLSessionHTTPClient: HTTPClient {
    private let session: URLSession
    
    public init(session: URLSession) {
        self.session = session
    }
    
    func get(url: URL, completion: @escaping (HTTPClientResult) -> Void) {
        session.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
            } else if let data = data, let response = response as? HTTPURLResponse {
                completion(.success(data, response))
            } else {
                completion(.failure(NSError(domain: "An error", code: 0, userInfo: nil)))
            }
        }.resume()
    }
}
