//
//  ForecastCollectionViewCell.swift
//  WeatherApp
//
//  Created by Grace Njoroge on 14/10/2020.
//  Copyright © 2020 Grace. All rights reserved.
//

import UIKit

class ForecastCollectionViewCell: UICollectionViewCell {

  lazy var dayImageView: UIImageView = {
    let img = UIImageView()
    img.contentMode = .scaleAspectFill
    img.image = UIImage(named: "forest_sunny")
    img.contentMode = .scaleAspectFit
    img.translatesAutoresizingMaskIntoConstraints = false
    return img
  }()

  lazy var dayLabel: UILabel = {
    let label = UILabel()
    label.text = "What day?"
    label.textColor = .white
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = UIFont.systemFont(ofSize: 15.0)
    return label
  }()

  lazy var tempLabel: UILabel = {
    let label = UILabel()
    label.text = "21º"
    label.textColor = .white
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = UIFont.systemFont(ofSize: 15.0)
    return label
  }()

  override init(frame: CGRect) {
    super.init(frame: frame)
    backgroundColor = .clear
    setupView()
  }

  fileprivate func setupView() {
    addSubview(dayLabel)
    addSubview(dayImageView)
    addSubview(tempLabel)

    NSLayoutConstraint.activate([
      dayLabel.topAnchor.constraint(equalTo: topAnchor, constant: 5),
      dayLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),

      dayImageView.topAnchor.constraint(equalTo: dayLabel.topAnchor),
      dayImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
      dayImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -18),

      tempLabel.topAnchor.constraint(equalTo: topAnchor, constant: 5),
      tempLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5)
    ])
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
    
}
