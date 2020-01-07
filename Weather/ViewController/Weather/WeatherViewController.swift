//
//  WeatherViewController.swift
//  Weather
//
//  Created by wiley on 2019/12/27.
//  Copyright © 2019 wiley. All rights reserved.
//

import UIKit
import CoreLocation

protocol WeatherViewControllerDelegate: class {
    func jumpCities()
}

class WeatherViewController: UIViewController, CLLocationManagerDelegate {
    // MARK: -
    weak var delegate: WeatherViewControllerDelegate?
    private let bag = DisposeBag()
    private var currentlyView = WeatherView()
    private var viewModel = WeatherViewModel()
    private var currentLocation: CLLocation? {
        didSet {
            requestCityInfo()
            requestWeatherInfo()
        }
    }
    private lazy var locationManager: CLLocationManager = {
       let manager = CLLocationManager()
        manager.distanceFilter = 1000
        manager.desiredAccuracy = 1000
        return manager
    }()
    
    // MARK: - ViewController Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // request location when application active
        view.backgroundColor = UIColor.systemBackground
        // View
        constructSubview()
        activeConstraints()
        setTargetAction()
        // Data
        applicationActiveNotification()
        // Bind
        bindData()
    }
    
    // MARK: - bind
    func bindData() {
        viewModel.name
            .bind(to: currentlyView.cityLabel.rx.text)
            .disposed(by: bag)
        viewModel.iconImage
            .bind(to: currentlyView.iconImageView.rx.image)
            .disposed(by: bag)
        viewModel.time
            .bind(to: currentlyView.timeLabel.rx.text)
            .disposed(by: bag)
    }
    
    // MARK: - views
    func constructSubview() {
        view.addSubview(currentlyView)
    }
    
    func activeConstraints() {
        activeConstraintsCurrentlyView()
    }
    
    func setTargetAction() {
        chooseButtonSetTargetAction()
    }
    
    func chooseButtonSetTargetAction() {
        currentlyView.chooseButton
            .rx
            .tap
            .subscribe(onNext: { [weak self] in
                self?.delegate?.jumpCities()
            })
            .disposed(by: bag)
    }
    
    // MARK: - Data
    // application active, get currently location
    private func applicationActiveNotification() {
        NotificationCenter.default
            .rx
            .notification(UIApplication.didBecomeActiveNotification)
            .subscribe(onNext: {_ in
                self.requestLocation()
            })
            .disposed(by: bag)
    }
    
    private func requestLocation() {
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            locationManager.startUpdatingLocation()
            locationManager
                .rx
                .didUpdateLocations
                .take(1)
                .subscribe(onNext: { [weak self] locations in
                    self?.currentLocation = locations.first
                })
                .disposed(by: bag)
        } else {
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    private func requestCityInfo() {
        guard let currentLocation = currentLocation else { return }
        
        viewModel.refreshCurrentlyCity(latitude: currentLocation.coordinate.latitude,
                                       longitude: currentLocation.coordinate.longitude)
    }
    
    private func requestWeatherInfo() {
        guard let currentLocation = currentLocation else { return }

        viewModel.requestWeatherData(latitude: currentLocation.coordinate.latitude,
                                     longitude: currentLocation.coordinate.longitude)
    }
}

extension WeatherViewController {
    func activeConstraintsCurrentlyView() {
        currentlyView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            currentlyView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            currentlyView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            currentlyView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            currentlyView.heightAnchor.constraint(equalToConstant: 300)
        ])
    }
}
