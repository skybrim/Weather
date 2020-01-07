//
//  CitiesView.swift
//  Weather
//
//  Created by wiley on 2020/1/6.
//  Copyright © 2020 wiley. All rights reserved.
//

import UIKit

class CitiesView: UIView {
    
    static let citiesReuseIdentifier = "citiesReuseIdentifier"
    
    var citiesTableView: UITableView = {
        let tableView = UITableView(frame: CGRect.zero, style: .grouped)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: CitiesView.citiesReuseIdentifier)
        return tableView
    }()
    
    override func didMoveToWindow() {
        super.didMoveToWindow()
        backgroundColor = UIColor.systemBackground
        
        constructSubview()
        activeConstraints()
    }
    
    func constructSubview() {
//        contentView.addArrangedSubview(searchBar)
//        contentView.addArrangedSubview(citiesTableView)
        addSubview(citiesTableView)
    }
    
    func activeConstraints() {
        activeConstraintsCitiesTableView()
    }
}

extension CitiesView {
    func activeConstraintsCitiesTableView() {
        citiesTableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            citiesTableView.topAnchor.constraint(equalTo: self.topAnchor),
            citiesTableView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            citiesTableView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            citiesTableView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
    }
}
