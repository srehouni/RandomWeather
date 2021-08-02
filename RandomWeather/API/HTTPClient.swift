//
//  HTTPClient.swift
//  RandomWeather
//
//  Created by Said Rehouni on 31/7/21.
//

import Foundation

protocol URLGenerator {
    func getURL() -> URL?
}

public enum HTTPClientResult {
    case success(Data, HTTPURLResponse)
    case failure(Error)
}

public protocol HTTPClient {
    func get(url: URL, completion: @escaping (HTTPClientResult) -> Void)
}
