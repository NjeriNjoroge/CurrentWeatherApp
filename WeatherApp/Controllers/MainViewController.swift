//
//  MainViewController.swift
//  WeatherApp
//
//  Created by Grace Njoroge on 13/10/2020.
//  Copyright © 2020 Grace. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

  lazy var firstContainerView: UIView = {
    let view = UIView()
    view.backgroundColor = .white
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()

  lazy var secondContainerView: UIView = {
    let view = UIView()
    view.backgroundColor = .red
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()

  lazy var mainImageView: UIImageView = {
    let img = UIImageView()
    img.contentMode = .scaleAspectFill
    img.image = UIImage(named: "forest_sunny")
    img.translatesAutoresizingMaskIntoConstraints = false
    return img
  }()

  lazy var waetherLabel: UILabel = {
    let label = UILabel()
    label.text = "SUNNY"
    label.textColor = .white
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = UIFont.systemFont(ofSize: 30.0)
    return label
  }()

  lazy var temparatureLabel: UILabel = {
    let label = UILabel()
    label.text = "21°"
    label.textColor = .white
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = UIFont.systemFont(ofSize: 40.0)
    return label
  }()

    override func viewDidLoad() {
        super.viewDidLoad()
      view.backgroundColor = .white

    }

  override func loadView() {
    super.loadView()
    setupView()
  }

  fileprivate func setupView() {
    let screenSize = UIScreen.main.bounds.size
    let height = screenSize.height

    view.addSubview(firstContainerView)
    firstContainerView.addSubview(mainImageView)
    firstContainerView.addSubview(temparatureLabel)
    firstContainerView.addSubview(waetherLabel)

    view.addSubview(secondContainerView)

    NSLayoutConstraint.activate([
      firstContainerView.topAnchor.constraint(equalTo: view.topAnchor),
      firstContainerView.widthAnchor.constraint(equalTo: view.widthAnchor),
      firstContainerView.heightAnchor.constraint(equalToConstant: height/2)
    ])
    NSLayoutConstraint.activate([
      mainImageView.topAnchor.constraint(equalTo: firstContainerView.topAnchor),
      mainImageView.widthAnchor.constraint(equalTo: firstContainerView.widthAnchor),
      mainImageView.heightAnchor.constraint(equalTo: firstContainerView.heightAnchor)
    ])

    NSLayoutConstraint.activate([
      secondContainerView.topAnchor.constraint(equalTo: firstContainerView.bottomAnchor),
      secondContainerView.widthAnchor.constraint(equalTo: view.widthAnchor),
      secondContainerView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
    ])

    NSLayoutConstraint.activate([
      temparatureLabel.centerYAnchor.constraint(equalTo: firstContainerView.centerYAnchor),
      temparatureLabel.centerXAnchor.constraint(equalTo: firstContainerView.centerXAnchor)
    ])

    NSLayoutConstraint.activate([
     waetherLabel.centerYAnchor.constraint(equalTo: firstContainerView.centerYAnchor, constant: -40),
     waetherLabel.centerXAnchor.constraint(equalTo: firstContainerView.centerXAnchor)
    ])


  }
    


}
