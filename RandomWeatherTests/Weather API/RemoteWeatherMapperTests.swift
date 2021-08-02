//
//  RemoteWeatherMapperTests.swift
//  RandomWeatherTests
//
//  Created by Said Rehouni on 31/7/21.
//

import XCTest
import RandomWeather

class RemoteWeatherLoaderMapperClass {
    func map(_ data: Data, from response: HTTPURLResponse) -> Weather? {
        return try? JSONDecoder().decode(RemoteWeather.self, from: data).toDomain()
    }
}

struct RemoteWeather: Decodable {
    let coord: RemoteLocation
    let weather: [RemoteWeatherInfo]
    let main: RemoteWeatherStats
    let wind: RemoteWeatherWind
    let sys: RemoteSys
    let name: String
}

extension RemoteWeather {
    func toDomain() -> Weather {
        return Weather(city: City(name: name,
                                  location: Location(latitude: coord.latitude,
                                                     longitude: coord.longitude)),
                       stats: WeatherStats(description: weather.first?.main.description ?? "",
                                           temperature: main.temp,
                                           feelsLike: main.feelsLike,
                                           minTemperature: main.tempMin,
                                           maxTemperature: main.tempMax,
                                           pressure: main.pressure,
                                           humidity: main.humidity))
    }
}

struct RemoteWeatherStats: Decodable {
    let temp: Float
    let feelsLike: Float
    let tempMin: Float
    let tempMax: Float
    let pressure: Int
    let humidity: Int
    
    enum CodingKeys: String, CodingKey {
        case temp, pressure, humidity
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
    }
}

struct RemoteWeatherInfo: Decodable {
    let main: String
    let description: String?
}

struct RemoteWeatherWind: Decodable {
    let speed: Float
    let deg: Float
}

struct RemoteLocation: Decodable {
    let longitude: Float
    let latitude: Float
    
    enum CodingKeys: String, CodingKey {
        case longitude = "lon"
        case latitude = "lat"
    }
}

struct RemoteSys: Decodable {
    let sunrise: Double
    let sunset: Double
}

class RemoteWeatherMapperTests: XCTestCase {
    
    func test_getsNilWhenMappingAnEmptyJSON() {
        let mapper = RemoteWeatherLoaderMapperClass()
        
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
        let mapper = RemoteWeatherLoaderMapperClass()
        
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
        let mapper = RemoteWeatherLoaderMapperClass()
        
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
                   "temp": 281.52,
                   "feels_like": 278.99,
                   "temp_min": 280.15,
                   "temp_max": 283.71,
                   "pressure": 1016,
                   "humidity": 93
                 },
                 "wind": {
                   "speed": 0.47,
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
    
    //MARK: - Helpers
    
    private func createRandomWeather() -> Weather {
        return Weather(city: City(name: "Shuzenji",
                        location: Location(latitude: 35,
                                              longitude: 139)),
                stats: WeatherStats(description: "Clear",
                                    temperature: 281.52,
                                    feelsLike: 278.99,
                                    minTemperature: 280.15,
                                    maxTemperature: 283.71,
                                    pressure: 1016,
                                    humidity: 93))
    }
}
