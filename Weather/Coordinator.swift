//
//  Coordinator.swift
//  Weather
//
//  Created by wiley on 2020/1/6.
//  Copyright © 2020 wiley. All rights reserved.
//

import UIKit
import CoreLocation

final class Coordinator {
    let rootVC: UIViewController
    var citiesNavgationController: UINavigationController!
    
    init(root: UIViewController) {
        rootVC = root
        
        if let rootVC = rootVC as? WeatherViewController {
            rootVC.delegate = self
        }
    }
}

extension Coordinator: WeatherViewControllerDelegate {
    func jumpCities() {
        let citiesVC = CitiesViewController(delegate: self)
        citiesNavgationController = UINavigationController(rootViewController: citiesVC)
        rootVC.present(citiesNavgationController, animated: true)
    }
}

extension Coordinator: CitiesViewControllerDelegate {
    func chooseLocation(_ location: CLLocation) {
        if let rootVC = rootVC as? WeatherViewController {
            rootVC.currentLocation = location
        }
        citiesNavgationController.dismiss(animated: true)
    }
}
