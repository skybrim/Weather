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
        imageView.tintColor = UIColor.systemOrange
        return imageView
    }()
    var timeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .title1)
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
        cityLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint
        .activate([
            cityLabel.topAnchor.constraint(equalTo: self.topAnchor),
            cityLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
    }

    func activeConstraintsIconImageView() {
        iconImageView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint
        .activate([
            iconImageView.heightAnchor.constraint(greaterThanOrEqualToConstant: 100),
            iconImageView.widthAnchor.constraint(greaterThanOrEqualToConstant: 100),
            iconImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            iconImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }

    func activeConstraintsTimeLabel() {
        timeLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint
        .activate([
            timeLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            timeLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}
