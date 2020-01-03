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
    private var currentlyView = CurrentlyView()
    private var viewModel = CurrentlyViewModel()
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
    
    // MARK: - Data
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
    // model 持有 City 的请求
    private func requestCityInfo() {
        guard let currentLocation = currentLocation else { return }
        
        Store.shared.refreshCurrentlyCity(latitude: currentLocation.coordinate.latitude,
                                          longitude: currentLocation.coordinate.longitude)
    }
    // 无需存储天气数据，所以 ViewModel 持有 Weather 请求
    private func requestWeatherInfo() {
        guard let currentLocation = currentLocation else { return }

        viewModel.requestWeatherData(latitude: currentLocation.coordinate.latitude,
                                     longitude: currentLocation.coordinate.longitude)
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
