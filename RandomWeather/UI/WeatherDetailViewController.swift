//
//  WeatherDetailViewController.swift
//  RandomWeather
//
//  Created by Said Rehouni on 2/8/21.
//

import UIKit
import RxSwift
import RxCocoa

public final class WeatherDetailViewController: UIViewController, Componentable {
    public var viewModel: WeatherDetailViewModel?
    
    public static let storyboardName = "WeatherDetail"
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var weatherDescriptionLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var feelsLikeLabel: UILabel!
    @IBOutlet weak var minTemperatureLabel: UILabel!
    @IBOutlet weak var maxTemperatureLabel: UILabel!
    @IBOutlet weak var pressureLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var windLabel: UILabel!
    
    var refreshControl: UIRefreshControl!
    
    private let disposeBag = DisposeBag()

    public override func viewDidLoad() {
        super.viewDidLoad()
        
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(loadWeather), for: UIControl.Event.valueChanged)
        scrollView.refreshControl = refreshControl
        
        setupObservers()
        
        loadWeather()
    }
    
    @objc func loadWeather() {
        viewModel?.loadWeather()
        refreshControl.endRefreshing()
    }
    
    public func setupObservers() {
        viewModel?.cityNameObservable
            .bind(to: cityNameLabel.rx.text)
            .disposed(by: disposeBag)
        
        viewModel?.descriptionObservable
            .bind(to: weatherDescriptionLabel.rx.text)
            .disposed(by: disposeBag)
        
        viewModel?.temperatureObservable
            .bind(to: temperatureLabel.rx.text)
            .disposed(by: disposeBag)
        
        viewModel?.feelsLikeObservable
            .bind(to: feelsLikeLabel.rx.text)
            .disposed(by: disposeBag)
        
        viewModel?.minTemperatureObservable
            .bind(to: minTemperatureLabel.rx.text)
            .disposed(by: disposeBag)
        
        viewModel?.maxTemperatureObservable
            .bind(to: maxTemperatureLabel.rx.text)
            .disposed(by: disposeBag)
        
        viewModel?.pressureObservable
            .bind(to: pressureLabel.rx.text)
            .disposed(by: disposeBag)
        
        viewModel?.humidityObservable
            .bind(to: humidityLabel.rx.text)
            .disposed(by: disposeBag)
        viewModel?.windObservable
            .bind(to: windLabel.rx.text)
            .disposed(by: disposeBag)
        
        //viewModel?.shouldPresentLoading
        //viewModel?.shouldPresentErrorMessage
    }
}

public extension WeatherDetailViewController {
    var cityName: String? { cityNameLabel.text }
    var weatherDescription: String? { weatherDescriptionLabel.text }
    var temperature: String? { temperatureLabel.text }
    var feelsLike: String? { feelsLikeLabel.text }
    var minTemperature: String? { minTemperatureLabel.text }
    var maxTemperature: String? { maxTemperatureLabel.text }
    var pressure: String? { pressureLabel.text }
    var humidity: String? { humidityLabel.text }
    var wind: String? { windLabel.text }
}