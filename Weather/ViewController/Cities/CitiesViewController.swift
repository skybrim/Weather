//
//  CitiesViewController.swift
//  Weather
//
//  Created by wiley on 2020/1/3.
//  Copyright © 2020 wiley. All rights reserved.
//

import UIKit

protocol CitiesViewControllerDelegate: class {
    func chooseCity(_ city: City)
}

class CitiesViewController: UIViewController {
    // MARK: -
    weak var delegate: CitiesViewControllerDelegate?

    // MARK: - ViewController Lifecycle
    convenience init(delegate: CitiesViewControllerDelegate) {
        self.init()
        self.delegate = delegate
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
    }
}
