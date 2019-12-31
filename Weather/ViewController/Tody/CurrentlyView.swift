//
//  CurrentlyView.swift
//  Weather
//
//  Created by wiley on 2019/12/30.
//  Copyright © 2019 wiley. All rights reserved.
//

import UIKit

class CurrentlyView: UIView {
    
    var cityLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        label.textColor = UIColor.label
        return label
    }()
    var iconImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    var timeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        label.textColor = UIColor.label
        return label
    }()
    
    // MARK: -
    override func didMoveToWindow() {
        super.didMoveToWindow()
        backgroundColor = UIColor.systemBackground
        
        constructSubview()
        activeConstraints()
    }
    
    func constructSubview() {
        addSubview(cityLabel)
        addSubview(iconImageView)
        addSubview(timeLabel)
    }
    
    func activeConstraints() {
        activeConstraintsCityLabel()
        activeConstraintsIconImageView()
        activeConstraintsTimeLabel()
    }
}

extension CurrentlyView {
    func activeConstraintsCityLabel() {
        NSLayoutConstraint
        .activate([
            cityLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            cityLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            cityLabel.topAnchor.constraint(equalTo: self.topAnchor)
        ])
    }
    
    func activeConstraintsIconImageView() {
        NSLayoutConstraint
        .activate([
            iconImageView.heightAnchor.constraint(equalToConstant: 100),
            iconImageView.widthAnchor.constraint(equalToConstant: 100),
            iconImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            iconImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
    
    func activeConstraintsTimeLabel() {
        NSLayoutConstraint
        .activate([
            timeLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            timeLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            timeLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}
