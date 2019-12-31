//
//  TodayViewController.swift
//  Weather
//
//  Created by wiley on 2019/12/27.
//  Copyright © 2019 wiley. All rights reserved.
//

import UIKit
import CoreLocation

class TodayViewController: UIViewController, CLLocationManagerDelegate {
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
    
    private var currentlyCity: BehaviorRelay<CurrentlyCityViewModel> =
        BehaviorRelay(value: .unkonw)
    private var currentlyWeather: BehaviorRelay<CurrentlyWeatherViewModel> =
        BehaviorRelay(value: .empty)
    
    // MARK: - ViewController Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // request location when application active
        applicationActiveNotification()
    }
    
    // MARK: - Location
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
    
    // MARK: - City Info
    private func geocodeCityInfo() {
        guard let currentLocation = currentLocation else { return }
        
        CLGeocoder().reverseGeocodeLocation(currentLocation) { (placemarks, error) in
            if let error = error {
                dump(error)
                self.currentlyCity
                    .accept(CurrentlyCityViewModel.unkonw)
                return
            }
            if let city = placemarks?.first?.locality,
                let district = placemarks?.first?.subLocality {
                print(city + district)
                let cityModel = City(city: city,
                                     district: district,
                                     latitude: currentLocation.coordinate.latitude,
                                     longitude: currentLocation.coordinate.longitude)
                self.currentlyCity
                    .accept(CurrentlyCityViewModel(city: cityModel))
            }
        }
    }
    
    // MARK: - Weather Info
    private func requestWeatherInfo() {
        guard let currentLocation = currentLocation else { return }

        let request = WeatherRequest<Weather>(
            location: (latitude: currentLocation.coordinate.latitude,
                       longitude: currentLocation.coordinate.longitude)
        )
        WeatherClient.shared.send(request) { result in
            switch result {
            case .success(let weather):
                dump(weather)
            case .failure(let error):
                dump(error)
            }
        }
    }
}
