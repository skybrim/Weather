//
//  WeatherView.swift
//  Weather
//
//  Created by wiley on 2019/12/30.
//  Copyright © 2019 wiley. All rights reserved.
//

import UIKit

class WeatherView: UIView {
    
    var cityLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        label.textColor = UIColor.label
        return label
    }()
    var chooseButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "location.fill"), for: .normal)
        return button
    }()
    var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    var temperatureLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .title1)
        label.textColor = UIColor.label
        return label
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
        addSubview(temperatureLabel)
        addSubview(timeLabel)
        addSubview(chooseButton)
    }
    
    func activeConstraints() {
        activeConstraintsCityLabel()
        activeConstraintsChooseButton()
        activeConstraintsIconImageView()
        activeConstraintsTimeLabel()
        activeConstraintsTemperatureLabel()
    }
}

extension WeatherView {
    func activeConstraintsCityLabel() {
        cityLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            cityLabel.topAnchor.constraint(equalTo: self.topAnchor),
            cityLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
    }

    func activeConstraintsChooseButton() {
        chooseButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            chooseButton.heightAnchor.constraint(equalToConstant: 44),
            chooseButton.widthAnchor.constraint(equalToConstant: 44),
            chooseButton.topAnchor.constraint(equalTo: self.topAnchor),
            chooseButton.rightAnchor.constraint(equalTo: self.rightAnchor)
            
        ])
    }
    
    func activeConstraintsIconImageView() {
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            iconImageView.heightAnchor.constraint(equalToConstant: 100),
            iconImageView.widthAnchor.constraint(equalToConstant: 100),
            iconImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            iconImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }

    func activeConstraintsTimeLabel() {
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            timeLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            timeLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    func activeConstraintsTemperatureLabel() {
        temperatureLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            temperatureLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            temperatureLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20)
        ])
    }
}
