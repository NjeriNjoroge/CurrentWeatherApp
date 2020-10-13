//
//  MainViewController.swift
//  WeatherApp
//
//  Created by Grace Njoroge on 13/10/2020.
//  Copyright © 2020 Grace. All rights reserved.
//

import UIKit
import CoreLocation
import Alamofire
import SwiftyJSON

class MainViewController: UIViewController {

  let weatherURL = "https://api.openweathermap.org/data/2.5/weather"
  let fiveDayForecast = "https://api.openweathermap.org/data/2.5/forecast"
  let appID = "0fd65ae8051cec4f21c386659c25955b"

  let locationManager = CLLocationManager()
  let weatherDataModel = WeatherDataModel()

  lazy var firstContainerView: UIView = {
    let view = UIView()
    view.backgroundColor = .white
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()

  lazy var secondContainerView: UIView = {
    let view = UIView()
    view.backgroundColor = UIColor(hexString: "#47ab2f")
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

//  lazy var currentTemperatureLabel: UILabel = {
//    let label = UILabel()
//    label.text = "current"
//    label.textColor = .white
//    label.translatesAutoresizingMaskIntoConstraints = false
//    label.font = UIFont.systemFont(ofSize: 15.0)
//    return label
//  }()


    override func viewDidLoad() {
        super.viewDidLoad()
      view.backgroundColor = .white
      locationManager.delegate = self
      locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
      locationManager.requestWhenInUseAuthorization()
      locationManager.startUpdatingLocation()

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

    setupLowerPartViews()

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
      temparatureLabel.centerYAnchor.constraint(equalTo: firstContainerView.centerYAnchor),
      temparatureLabel.centerXAnchor.constraint(equalTo: firstContainerView.centerXAnchor)
    ])

    NSLayoutConstraint.activate([
     waetherLabel.centerYAnchor.constraint(equalTo: firstContainerView.centerYAnchor, constant: -40),
     waetherLabel.centerXAnchor.constraint(equalTo: firstContainerView.centerXAnchor)
    ])
  }

  func setupLowerPartViews() {
    view.addSubview(secondContainerView)
    secondContainerView.addSubview(minTemperature)
    secondContainerView.addSubview(minTemperatureLabel)
    secondContainerView.addSubview(currentTemperature)
    secondContainerView.addSubview(currentTemperatureLabel)
    secondContainerView.addSubview(maxTemperature)
    secondContainerView.addSubview(maxTemperatureLabel)
    secondContainerView.addSubview(lineView)

    NSLayoutConstraint.activate([
      secondContainerView.topAnchor.constraint(equalTo: firstContainerView.bottomAnchor),
      secondContainerView.widthAnchor.constraint(equalTo: view.widthAnchor),
      secondContainerView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
    ])
    NSLayoutConstraint.activate([
      minTemperature.topAnchor.constraint(equalTo: secondContainerView.topAnchor),
      minTemperature.leadingAnchor.constraint(equalTo: secondContainerView.leadingAnchor, constant: 10)
    ])
    NSLayoutConstraint.activate([
      minTemperatureLabel.topAnchor.constraint(equalTo: minTemperature.bottomAnchor),
      minTemperatureLabel.leadingAnchor.constraint(equalTo: minTemperature.leadingAnchor)
    ])
    NSLayoutConstraint.activate([
      currentTemperature.topAnchor.constraint(equalTo: secondContainerView.topAnchor),
      currentTemperature.centerXAnchor.constraint(equalTo: secondContainerView.centerXAnchor)
    ])
    NSLayoutConstraint.activate([
      currentTemperatureLabel.topAnchor.constraint(equalTo: currentTemperature.bottomAnchor),
      currentTemperatureLabel.centerXAnchor.constraint(equalTo: currentTemperature.centerXAnchor)
    ])
    NSLayoutConstraint.activate([
      maxTemperature.topAnchor.constraint(equalTo: secondContainerView.topAnchor),
      maxTemperature.trailingAnchor.constraint(equalTo: secondContainerView.trailingAnchor, constant: -10)
    ])
    NSLayoutConstraint.activate([
      maxTemperatureLabel.topAnchor.constraint(equalTo: maxTemperature.bottomAnchor),
      maxTemperatureLabel.trailingAnchor.constraint(equalTo: maxTemperature.trailingAnchor)
    ])
    NSLayoutConstraint.activate([
      lineView.topAnchor.constraint(equalTo: currentTemperatureLabel.bottomAnchor),
      lineView.widthAnchor.constraint(equalTo: secondContainerView.widthAnchor),
      lineView.heightAnchor.constraint(equalToConstant: 1)
    ])

  }

  fileprivate func getWeatherData(url: String, parameters: [String: String]) {
    AF.request(url, method: .get, parameters: parameters).responseJSON { response in
      switch response.result {
      case .success:
        let weatherJSON: JSON = JSON(response.data!)
        self.updateWeatherData(json: weatherJSON)

      case .failure(let error):
        print("Error \(error)")
        self.waetherLabel.text = "Connectivity Issues"
      }
    }
  }

  fileprivate func getWeatherFiveDay(url: String, parameters: [String: String]) {
    AF.request(url, method: .get, parameters: parameters).responseJSON { response in
      switch response.result {
      case .success:
        let weatherJSON: JSON = JSON(response.data!)
        print(weatherJSON)
        //self.updateWeatherData(json: weatherJSON)

      case .failure(let error):
        print("Error \(error)")
        self.waetherLabel.text = "Connectivity Issues"
      }
    }
  }

  fileprivate func updateWeatherData(json: JSON) {
    if let tempResult = json["main"]["temp"].double {
      let city = json["name"].stringValue
      let condition = json["weather"][0]["id"].intValue
      let weatherStr = json["weather"][0]["main"].stringValue
      weatherDataModel.weatherDescription = weatherStr
      weatherDataModel.temperature = Int(tempResult - 273.15)
      weatherDataModel.city = city
      weatherDataModel.condition = condition
      weatherDataModel.weatherIcon = weatherDataModel.updateWeatherIcon(condition: weatherDataModel.condition)
      updateUIWithWeatherData()
    } else {
      //loadingLabel.text = "Weather Unavailable"
    }
  }

  fileprivate func updateUIWithWeatherData() {
    waetherLabel.text = weatherDataModel.weatherDescription
    temparatureLabel.text = "\(weatherDataModel.temperature)°"
    //mainImageView.image = UIImage(named: weatherDataModel.weatherIcon)
  }

}

extension MainViewController: CLLocationManagerDelegate {
  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    let location = locations[locations.count - 1] //get last value
    if location.horizontalAccuracy > 0 {
      locationManager.stopUpdatingLocation()
      let latitude = String(location.coordinate.latitude)
      let longitude = String(location.coordinate.longitude)
      let params: [String: String] = ["lat": latitude, "lon": longitude, "appid": appID]
      getWeatherData(url: weatherURL, parameters: params)
      getWeatherFiveDay(url: fiveDayForecast, parameters: params)
    }
  }
  func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
    print(error)
    waetherLabel.text = "Location Unavailable"
  }
}


