//
//  Components.swift
//  RandomWeather
//
//  Created by Said Rehouni on 2/8/21.
//

import Foundation
import UIKit

class Components {
    static func createWeatherComponent() -> UIViewController {
        let viewModel = WeatherDetailViewModel(weatherLoader: createRemoteweatherLoader(),
                                               weatherLoaderErrorHandling: RemoteWeatherLoaderErrorHandling())
        let viewController: WeatherDetailViewController = WeatherDetailViewController.create(viewModel: viewModel)
        viewController.progressView = ProgressViewComponent()
        
        return viewController
    }
}

extension Components {
    static func createRemoteweatherLoader() -> WeatherLoader {
        RemoteWeatherLoader(urlGenerator: RandomURLGenerator(apiKey: RandomWeatherConstants.apiKey),
                            client: URLSessionHTTPClient(session: .shared),
                            mapper: RemoteWeatherLoaderMapper())
    }
}
