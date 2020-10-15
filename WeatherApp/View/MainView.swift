//
//  MainView.swift
//  WeatherApp
//
//  Created by Grace Njoroge on 15/10/2020.
//  Copyright © 2020 Grace. All rights reserved.
//

import UIKit

class MainView: UIView {

  lazy var minTemperature: UILabel = {
    let label = UILabel()
    label.text = "19°"
    label.textColor = .white
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = UIFont.systemFont(ofSize: 15.0)
    return label
  }()

  lazy var minTemperatureLabel: UILabel = {
    let label = UILabel()
    label.text = "min"
    label.textColor = .white
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = UIFont.systemFont(ofSize: 15.0)
    return label
  }()

  lazy var currentTemperature: UILabel = {
    let label = UILabel()
    label.text = "24°"
    label.textColor = .white
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = UIFont.systemFont(ofSize: 15.0)
    return label
  }()

  lazy var currentTemperatureLabel: UILabel = {
    let label = UILabel()
    label.text = "current"
    label.textColor = .white
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = UIFont.systemFont(ofSize: 15.0)
    return label
  }()

  lazy var maxTemperature: UILabel = {
    let label = UILabel()
    label.text = "25°"
    label.textColor = .white
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = UIFont.systemFont(ofSize: 15.0)
    return label
  }()

  lazy var maxTemperatureLabel: UILabel = {
    let label = UILabel()
    label.text = "max"
    label.textColor = .white
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = UIFont.systemFont(ofSize: 15.0)
    return label
  }()

  lazy var lineView: UIView = {
    let view = UIView()
    view.backgroundColor = .white
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()

  override init(frame: CGRect) {
    super.init(frame: frame)
    setupView()
  }

  func setupView() {
    addSubview(minTemperature)
    addSubview(minTemperatureLabel)
    addSubview(currentTemperature)
    addSubview(currentTemperatureLabel)
    addSubview(maxTemperature)
    addSubview(maxTemperatureLabel)
    addSubview(lineView)
    
    NSLayoutConstraint.activate([
       minTemperature.topAnchor.constraint(equalTo: topAnchor),
       minTemperature.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10)
     ])

     NSLayoutConstraint.activate([
       minTemperatureLabel.topAnchor.constraint(equalTo: minTemperature.bottomAnchor),
       minTemperatureLabel.leadingAnchor.constraint(equalTo: minTemperature.leadingAnchor)
     ])

     NSLayoutConstraint.activate([
       currentTemperature.topAnchor.constraint(equalTo: topAnchor),
       currentTemperature.centerXAnchor.constraint(equalTo: centerXAnchor)
     ])

     NSLayoutConstraint.activate([
       currentTemperatureLabel.topAnchor.constraint(equalTo: currentTemperature.bottomAnchor),
       currentTemperatureLabel.centerXAnchor.constraint(equalTo: currentTemperature.centerXAnchor)
     ])

     NSLayoutConstraint.activate([
       maxTemperature.topAnchor.constraint(equalTo: topAnchor),
       maxTemperature.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10)
     ])

     NSLayoutConstraint.activate([
       maxTemperatureLabel.topAnchor.constraint(equalTo: maxTemperature.bottomAnchor),
       maxTemperatureLabel.trailingAnchor.constraint(equalTo: maxTemperature.trailingAnchor)
     ])

     NSLayoutConstraint.activate([
       lineView.topAnchor.constraint(equalTo: currentTemperatureLabel.bottomAnchor),
       lineView.widthAnchor.constraint(equalTo: widthAnchor),
       lineView.heightAnchor.constraint(equalToConstant: 1)
     ])
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

}
