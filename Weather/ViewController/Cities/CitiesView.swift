//
//  CitiesView.swift
//  Weather
//
//  Created by wiley on 2020/1/6.
//  Copyright © 2020 wiley. All rights reserved.
//

import UIKit

class CitiesView: UIView {
    
    var contentView: UIStackView = {
        let stackView = UIStackView()
        return stackView
    }()
    
    var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        return searchBar
    }()
    
    var citiesTableView: UITableView = {
        let tableView = UITableView(frame: CGRect.zero, style: .plain)
        return tableView
    }()
    
    override func didMoveToWindow() {
        super.didMoveToWindow()
        backgroundColor = UIColor.systemBackground
        
        constructSubview()
        activeConstraints()
    }
    
    func constructSubview() {
        addSubview(contentView)
    }
    
    func activeConstraints() {
        activeConstraintsContentView()
        activeConstraintsSearchBar()
        activeConstraintsCitiesTableView()
    }
}

extension CitiesView {
    func activeConstraintsContentView() {
        
    }
    
    func activeConstraintsSearchBar() {
        
    }
    
    func activeConstraintsCitiesTableView() {
        
    }
}
