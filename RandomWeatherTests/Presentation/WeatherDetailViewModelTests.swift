//
//  WeatherDetailViewModelTests.swift
//  RandomWeatherTests
//
//  Created by Said Rehouni on 2/8/21.
//

import XCTest
import RandomWeather
import RxSwift

class WeatherDetailViewModelTests: XCTestCase {

    func test_triesToLoadWeatherAndFails() {
        let weatherLoader = WeatherLoaderSpy()
        let viewModel = WeatherDetailViewModel(weatherLoader: weatherLoader,
                                               weatherLoaderErrorHandling: RemoteWeatherLoaderErrorHandling())
        
        let disposeBag = DisposeBag()
        weatherLoader.result = .failure(NSError(domain: "An error", code: 0, userInfo: nil))
        
        viewModel.loadWeather()
        
        var capturedValue: String?
        viewModel.shouldPresentErrorMessage.subscribe(onNext: { value in
            capturedValue = value
        }).disposed(by: disposeBag)
        
        XCTAssertNotNil(capturedValue)
    }
    
    func test_triesToLoadWeatherAndSucceeds() {
        let weatherLoader = WeatherLoaderSpy()
        let viewModel = WeatherDetailViewModel(weatherLoader: weatherLoader,
                                               weatherLoaderErrorHandling: RemoteWeatherLoaderErrorHandling())
        let disposeBag = DisposeBag()
        
        weatherLoader.result = .success(createRandomWeather())
        
        viewModel.loadWeather()
        
        var capturedValues = [String?]()
        
        viewModel.cityNameObservable.subscribe(onNext: { value in
            capturedValues.append(value)
        }).disposed(by: disposeBag)
        
        viewModel.descriptionObservable.subscribe(onNext: { value in
            capturedValues.append(value)
        }).disposed(by: disposeBag)
        
        viewModel.temperatureObservable.subscribe(onNext: { value in
            capturedValues.append(value)
        }).disposed(by: disposeBag)
        
        viewModel.feelsLikeObservable.subscribe(onNext: { value in
            capturedValues.append(value)
        }).disposed(by: disposeBag)
        
        viewModel.minTemperatureObservable.subscribe(onNext: { value in
            capturedValues.append(value)
        }).disposed(by: disposeBag)
        
        viewModel.maxTemperatureObservable.subscribe(onNext: { value in
            capturedValues.append(value)
        }).disposed(by: disposeBag)
        
        viewModel.pressureObservable.subscribe(onNext: { value in
            capturedValues.append(value)
        }).disposed(by: disposeBag)
        
        viewModel.humidityObservable.subscribe(onNext: { value in
            capturedValues.append(value)
        }).disposed(by: disposeBag)
        
        viewModel.windObservable.subscribe(onNext: { value in
            capturedValues.append(value)
        }).disposed(by: disposeBag)
        
        XCTAssertEqual(capturedValues, ["Shuzenji", "Clear", "23º", "23º", "Min 19º", "Máx 25º", "1016 hPa", "93%", "7.8km/h"])
    }
}
