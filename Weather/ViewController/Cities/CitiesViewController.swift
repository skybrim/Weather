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
    private let bag = DisposeBag()
    private var citieseView = CitiesView()
    private var viewModel = CitiesViewModel()
    
    // MARK: - ViewController Lifecycle
    convenience init(delegate: CitiesViewControllerDelegate) {
        self.init()
        self.delegate = delegate
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // View
        constructSubview()
        activeConstraints()
        // Bind
        bindData()
    }
    
    func bindData() {
        viewModel.titles
            .bind(to:
                 citieseView.citiesTableView
                .rx
                .items(cellIdentifier: CitiesView.citiesReuseIdentifier, cellType: UITableViewCell.self)
            ) { (_, text, cell) in
                cell.textLabel?.text = text
            }
            .disposed(by: bag)
    }
    
    func constructSubview() {
        view.addSubview(citieseView)
    }
    
    func activeConstraints() {
        activeConstraintsCitiesTableView()
    }
}

extension CitiesViewController {
    func activeConstraintsCitiesTableView() {
        citieseView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            citieseView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            citieseView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            citieseView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            citieseView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
