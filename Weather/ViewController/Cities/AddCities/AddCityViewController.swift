//
//  AddCityViewController.swift
//  Weather
//
//  Created by wiley on 2020/1/7.
//  Copyright © 2020 wiley. All rights reserved.
//

import UIKit

class AddCityViewController: UIViewController {
    
    private let bag = DisposeBag()
    private var addCityView = AddCityView()
    private var viewModel = AddCityViewModel()
    
    // MARK: - ViewController Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Add City"
        view.backgroundColor = UIColor.systemBackground
        
        // View
        constructSubview()
        activeConstraints()
        setTargetAction()
        // Bind
        bindData()
    }
    
    func bindData() {
        
    }
    
    func constructSubview() {
        view.addSubview(addCityView)
    }
    
    func activeConstraints() {
        activeConstraintsAddCityView()
    }
    
    func setTargetAction() {
        
    }
}

extension AddCityViewController {
    func activeConstraintsAddCityView() {
        addCityView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            addCityView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            addCityView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            addCityView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            addCityView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
