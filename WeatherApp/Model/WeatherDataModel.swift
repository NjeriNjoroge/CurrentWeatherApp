//
//  WeatherDataModel.swift
//  WeatherApp
//
//  Created by Grace Njoroge on 13/10/2020.
//  Copyright © 2020 Grace. All rights reserved.
//

import UIKit

class WeatherDataModel {

  var temperature: Int = 0
  var weatherDescription: String = ""
  var weatherIcon: String = ""
  var minimumTemp: Int = 0
  var maximumTemp: Int = 0

  func updateWeatherIcon(condition: String) -> UIImage {

    switch (condition) {

    case "Clouds" :
      return UIImage(named: "forest_cloudy")!

    case "Clear" :
      return UIImage(named: "forest_sunny")!

    case "Rain" :
      return UIImage(named: "forest_rainy")!

    default :
      return UIImage(named: "forest_sunny")!
    }

  }

}

