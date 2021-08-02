//
//  RemoteWeatherMapperTests.swift
//  RandomWeatherTests
//
//  Created by Said Rehouni on 31/7/21.
//

import XCTest
import RandomWeather

class RemoteWeatherMapperTests: XCTestCase {
    
    func test_getsNilWhenMappingAnEmptyJSON() {
        let mapper = RemoteWeatherLoaderMapper()
        
        let json = """
            {}
            """
        
        let data = Data(json.utf8)
        let weather = mapper.map(data, from: HTTPURLResponse(url: URL(string: "https://google.com")!,
                                                            statusCode: 200,
                                                            httpVersion: nil,
                                                            headerFields: nil)!)

        XCTAssertNil(weather)
    }
    
    func test_getsCorrectWeatherWhenMappingAWrongJSON() {
        let mapper = RemoteWeatherLoaderMapper()
        
        let json = """
            {"test" : "test"}
            """
        
        let data = Data(json.utf8)
        let weather = mapper.map(data, from: HTTPURLResponse(url: URL(string: "https://google.com")!,
                                                            statusCode: 200,
                                                            httpVersion: nil,
                                                            headerFields: nil)!)

        XCTAssertNil(weather)
    }
    
    func test_getsCorrectWeatherWhenMappingCorrectJSON() {
        let mapper = RemoteWeatherLoaderMapper()
        
        let json = """
            {"coord": { "lon": 139,"lat": 35},
                 "weather": [
                   {
                     "id": 800,
                     "main": "Clear",
                     "description": "clear sky",
                     "icon": "01n"
                   }
                 ],
                 "base": "stations",
                 "main": {
                   "temp": 296.15,
                   "feels_like": 296.15,
                   "temp_min": 292.15,
                   "temp_max": 298.15,
                   "pressure": 1016,
                   "humidity": 93
                 },
                 "wind": {
                   "speed": 7.8,
                   "deg": 107.538
                 },
                 "clouds": {
                   "all": 2
                 },
                 "dt": 1560350192,
                 "sys": {
                   "type": 3,
                   "id": 2019346,
                   "message": 0.0065,
                   "country": "JP",
                   "sunrise": 1560281377,
                   "sunset": 1560333478
                 },
                 "timezone": 32400,
                 "id": 1851632,
                 "name": "Shuzenji",
                 "cod": 200
                 }
            """
        
        let data = Data(json.utf8)
        let weather = mapper.map(data, from: HTTPURLResponse(url: URL(string: "https://google.com")!,
                                                            statusCode: 200,
                                                            httpVersion: nil,
                                                            headerFields: nil)!)
    
        XCTAssertEqual(weather, createRandomWeather())
    }
}
