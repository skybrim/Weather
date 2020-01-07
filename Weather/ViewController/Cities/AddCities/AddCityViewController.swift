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
        viewModel.titles
            .bind(to: addCityView
                .citiesTableView
                .rx
                .items(cellIdentifier: AddCityView.addCityReuseIdentifier)
            ) { (_, title, cell) in
                cell.textLabel?.text = title
            }
            .disposed(by: bag)
    }
    
    func constructSubview() {
        view.addSubview(addCityView)
    }
    
    func activeConstraints() {
        activeConstraintsAddCityView()
    }
    
    func setTargetAction() {
        searchBarSetTargetAction()
        tableViewSelected()
    }
    
    func searchBarSetTargetAction() {
        addCityView.searchBar
            .rx
            .searchButtonClicked
            .subscribe(onNext: { [weak self] in
                self?.viewModel.queryText = self?.addCityView.searchBar.text
            })
            .disposed(by: bag)
    }
    
    func tableViewSelected() {
        addCityView.citiesTableView
            .rx
            .itemSelected
            .subscribe(onNext: { [weak self] index in
                self?.viewModel.addCity(index.row)
                self?.navigationController?.popViewController(animated: true)
            })
            .disposed(by: bag)
        
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
