//
//  CitiesViewController.swift
//  Weather
//
//  Created by wiley on 2020/1/3.
//  Copyright © 2020 wiley. All rights reserved.
//

import UIKit
import CoreLocation

protocol CitiesViewControllerDelegate: class {
    func chooseLocation(_ location: CLLocation)
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
        setTargetAction()
        // Bind
        bindData()
    }
    
    func bindData() {
        viewModel.titles
            .bind(to:
                 citieseView.citiesTableView
                .rx
                .items(cellIdentifier: CitiesView.citiesReuseIdentifier, cellType: UITableViewCell.self)
            ) { (_, title, cell) in
                cell.textLabel?.text = title
            }
            .disposed(by: bag)
    }
    
    func constructSubview() {
        view.addSubview(citieseView)
    }
    
    func activeConstraints() {
        activeConstraintsCitiesTableView()
    }
    
    func setTargetAction() {
        doneSetTargetAction()
        addSetTargetAction()
        tableViewSelected()
    }
    
    func doneSetTargetAction() {
        let doneBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done,
                                                target: nil, action: nil)
        doneBarButtonItem.rx
            .tap
            .subscribe(onNext: { [weak self] in
                self?.navigationController?.dismiss(animated: true)
            })
            .disposed(by: bag)
        navigationItem.rightBarButtonItem = doneBarButtonItem
    }
    
    func addSetTargetAction() {
        let addBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
                                               target: nil, action: nil)
        addBarButtonItem.rx
            .tap
            .subscribe(onNext: { [weak self] in
                self?.navigationController?
                    .pushViewController(AddCityViewController(), animated: true)
            })
            .disposed(by: bag)
        navigationItem.leftBarButtonItem = addBarButtonItem
    }
    
    func tableViewSelected() {
        citieseView.citiesTableView
            .rx
            .itemSelected
            .subscribe(onNext: { [weak self] index in
                if let city = self?.viewModel.cities.value[index.row] {
                    self?.delegate?
                        .chooseLocation(CLLocation(latitude: city.latitude, longitude: city.longitude))
                }
            })
            .disposed(by: bag)
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
