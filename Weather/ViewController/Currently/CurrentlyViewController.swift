//
//  CurrentlyViewController.swift
//  Weather
//
//  Created by wiley on 2019/12/27.
//  Copyright © 2019 wiley. All rights reserved.
//

import UIKit
import CoreLocation

class CurrentlyViewController: UIViewController, CLLocationManagerDelegate {
    // MARK: -
    private let bag = DisposeBag()
    
    private lazy var locationManager: CLLocationManager = {
       let manager = CLLocationManager()
        manager.distanceFilter = 1000
        manager.desiredAccuracy = 1000
        return manager
    }()
    
    private var currentLocation: CLLocation? {
        didSet {
            geocodeCityInfo()
            requestWeatherInfo()
        }
    }
    
    private var currentlyView = CurrentlyView()
    
    private var viewModel = CurrentlyViewModel()
    
    // MARK: - ViewController Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // request location when application active
        view.backgroundColor = UIColor.systemBackground
        // view
        constructSubview()
        activeConstraints()
        // model
        applicationActiveNotification()
        // bind
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
    }
    
    // MARK: - views
    func constructSubview() {
        view.addSubview(currentlyView)
    }
    
    func activeConstraints() {
        activeConstraintsCurrentlyView()
    }
    
    // MARK: - Models
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
    
    private func geocodeCityInfo() {
        guard let currentLocation = currentLocation else { return }
        
        CLGeocoder().reverseGeocodeLocation(currentLocation) { (placemarks, error) in
            if let error = error {
                dump(error)
                return
            }
            if let name = placemarks?.first?.locality,
                let district = placemarks?.first?.subLocality {
                let cityModel = City(name: name,
                                     district: district,
                                     latitude: currentLocation.coordinate.latitude,
                                     longitude: currentLocation.coordinate.longitude)
                self.viewModel.city.accept(cityModel)
            }
        }
    }
    
    private func requestWeatherInfo() {
        guard let currentLocation = currentLocation else { return }

        let request = WeatherRequest<Weather>(
            location: (latitude: currentLocation.coordinate.latitude,
                       longitude: currentLocation.coordinate.longitude)
        )
        WeatherClient.shared.send(request) { result in
            switch result {
            case .success(let weather):
                self.viewModel.weather.accept(weather)
            case .failure(let error):
                dump(error)
            }
        }
    }
}

extension CurrentlyViewController {
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
