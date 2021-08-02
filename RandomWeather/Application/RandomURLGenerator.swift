//
//  RandomURLGenerator.swift
//  RandomWeather
//
//  Created by Said Rehouni on 2/8/21.
//

import Foundation

public class RandomURLGenerator: URLGenerator {
    let apiKey: String
    
    init(apiKey: String) {
        self.apiKey = apiKey
    }
    
    func getURL() -> URL? {
        return URL(string: "https://api.openweathermap.org/data/2.5/weather?lon=153.7805&lat=-16.52388&appid=\(apiKey)")
    }
    
    func getRandomCoordinates() -> (long: Float, lat: Float) {
        return (long: Float.random(in: 0.0...1.0) * 360 - 180, lat: Float.random(in: 0.0...1.0) * 180 - 90)
    }
}
