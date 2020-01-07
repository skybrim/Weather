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
    
    var contentView: UIStackView = {
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
        contentView.addArrangedSubview(searchBar)
        contentView.addArrangedSubview(citiesTableView)
        addSubview(contentView)
    }
    
    func activeConstraints() {
        activeConstraintsContentView()
    }
}

extension CitiesView {
    func activeConstraintsContentView() {
        contentView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint
        .activate([
            contentView.topAnchor.constraint(equalTo: self.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            contentView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
    }
}
