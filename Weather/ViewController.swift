//
//  ViewController.swift
//  Weather
//
//  Created by wiley on 2019/12/27.
//  Copyright © 2019 wiley. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        let shenzhen = City(name: "shenzhen", latitude: 22.5431, longitude: 114.0579)

        let request = WeatherRequest<Weather>(location:
            (latitude: shenzhen.latitude,
             longitude: shenzhen.longitude)
        )
        WeatherClient.shared.send(request) { (result) in
            switch result {
            case .success(let model):
                dump(model)
            case .failure(let error):
                dump(error)
            }
        }
    }
}
