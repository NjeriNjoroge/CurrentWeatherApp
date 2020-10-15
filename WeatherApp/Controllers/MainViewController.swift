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
  private let spacing:CGFloat = 16.0
  var weatherArray = [WeatherForecast]()

  let locationManager = CLLocationManager()
  let weatherDataModel = WeatherDataModel()
  let mainView = MainView()

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

  lazy var collectionView: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    let cv = UICollectionView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: layout)
    cv.translatesAutoresizingMaskIntoConstraints = false
    cv.backgroundColor = .clear
    return cv
  }()

    override func viewDidLoad() {
        super.viewDidLoad()
      view.backgroundColor = .white
      getUsersLocation()

      collectionView.register(ForecastCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
      collectionView.delegate = self
      collectionView.dataSource = self
    }

  override func loadView() {
    super.loadView()
    setupView()
  }

  fileprivate func getUsersLocation() {
    locationManager.delegate = self
    locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
    locationManager.requestWhenInUseAuthorization()
    locationManager.startUpdatingLocation()
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
    secondContainerView.addSubview(mainView)
    mainView.translatesAutoresizingMaskIntoConstraints = false
    secondContainerView.addSubview(collectionView)

    NSLayoutConstraint.activate([
      secondContainerView.topAnchor.constraint(equalTo: firstContainerView.bottomAnchor),
      secondContainerView.widthAnchor.constraint(equalTo: view.widthAnchor),
      secondContainerView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
    ])

    NSLayoutConstraint.activate([
      mainView.topAnchor.constraint(equalTo: secondContainerView.topAnchor),
      mainView.heightAnchor.constraint(equalToConstant: 35),
      mainView.trailingAnchor.constraint(equalTo: secondContainerView.trailingAnchor),
      mainView.leadingAnchor.constraint(equalTo: secondContainerView.leadingAnchor)
    ])

    NSLayoutConstraint.activate([
      collectionView.topAnchor.constraint(equalTo: mainView.bottomAnchor),
      collectionView.leadingAnchor.constraint(equalTo: secondContainerView.leadingAnchor),
      collectionView.trailingAnchor.constraint(equalTo: secondContainerView.trailingAnchor),
      collectionView.bottomAnchor.constraint(equalTo: secondContainerView.bottomAnchor)
    ])
  }

  fileprivate func getWeatherForecast(_ params: [String: String], completionHandler: @escaping ([WeatherForecast]) -> Void) {
    WebService.getForecast(params) { (json) in
      let results = Parse.parseForecastDetails(json: json)
      for all in results {
        self.weatherArray.append(all)
      }
      DispatchQueue.main.async {
        self.collectionView.reloadData()
      }
      completionHandler(results)
    }
  }


  fileprivate func updateWeatherData(json: JSON) {
    if let tempResult = json["main"]["temp"].double, let maxTempResult = json["main"]["temp_max"].double, let minTempResult = json["main"]["temp_min"].double {
      let weatherIcon = json["weather"][0]["main"].stringValue
      let weatherStr = json["weather"][0]["main"].stringValue

      weatherDataModel.weatherDescription = weatherStr
      weatherDataModel.temperature = Int(tempResult - 273.15)
      weatherDataModel.maximumTemp = Int(maxTempResult - 273.15)
      weatherDataModel.minimumTemp = Int(minTempResult - 273.15)
      weatherDataModel.weatherIcon = weatherIcon

      updateUIWithWeatherData()
    } else {
      waetherLabel.text = "Weather Unavailable"
    }
  }


  fileprivate func updateUIWithWeatherData() {
    DispatchQueue.main.async {
      self.waetherLabel.text = self.weatherDataModel.weatherDescription
      self.temparatureLabel.text = "\(self.weatherDataModel.temperature)°"
      self.mainImageView.image = self.weatherDataModel.updateWeatherIcon(condition: self.weatherDataModel.weatherIcon)
      self.mainView.currentTemperature.text = "\(self.weatherDataModel.temperature)°"
      self.mainView.maxTemperature.text = "\(self.weatherDataModel.maximumTemp)°"
      self.mainView.minTemperature.text = "\(self.weatherDataModel.minimumTemp)°"
    }
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

      //get weather
      WebService.getWeather(params) { (json) in
        self.updateWeatherData(json: json)
        print("weather results")
      }

      //get forecast
      WebService.getForecast(params) { (json) in
        self.getWeatherForecast(params) { (json) in
          print("forecast results")
        }
      }
    }

  }
  func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
    print(error)
    waetherLabel.text = "Location Unavailable"
  }

}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return weatherArray.count
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ForecastCollectionViewCell

    cell.dayLabel.text = weatherArray[indexPath.row].dailyDate

    let temp = Int(weatherArray[indexPath.row].dailyTemp - 273.15)
    cell.tempLabel.text = "\(temp)º"

    let stringImage = weatherArray[indexPath.row].dailyIcon
    let url = "http://openweathermap.org/img/wn/\(stringImage)@2x.png"
    cell.dayImageView.image = UIImage(url: URL(string: url))

    return cell
  }

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: collectionView.bounds.width, height: 50)
  }

}
