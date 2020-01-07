//
//  AddCityView.swift
//  Weather
//
//  Created by wiley on 2020/1/7.
//  Copyright © 2020 wiley. All rights reserved.
//

import UIKit

class AddCityView: UIView {

    static let addCityReuseIdentifier = "addCityReuseIdentifier"

    var containerView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 0
        stackView.distribution = .fill
        stackView.alignment = .fill
        return stackView
    }()

    var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        return searchBar
    }()
    
    var citiesTableView: UITableView = {
        let tableView = UITableView(frame: CGRect.zero, style: .plain)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: AddCityView.addCityReuseIdentifier)
        return tableView
    }()
    
    override func didMoveToWindow() {
        super.didMoveToWindow()
        backgroundColor = UIColor.systemBackground
        
        constructSubview()
        activeConstraints()
    }
    
    func constructSubview() {
        containerView.addArrangedSubview(searchBar)
        containerView.addArrangedSubview(citiesTableView)
        addSubview(containerView)
    }
    
    func activeConstraints() {
        activeConstraintsContainerView()
    }
}

extension AddCityView {
    func activeConstraintsContainerView() {
        containerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: self.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            containerView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            containerView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
    }
}
