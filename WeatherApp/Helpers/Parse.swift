//
//  Parse.swift
//  WeatherApp
//
//  Created by Grace Njoroge on 14/10/2020.
//  Copyright © 2020 Grace. All rights reserved.
//


import Foundation
import SwiftyJSON

public class Parse {

  var forecast = [WeatherForecast]()

  static func convertUtcToLocalTime (date :String) -> String {

    let dateFormatterGet = DateFormatter()
    dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm:ss"

    let dateFormatterPrint = DateFormatter()
    dateFormatterPrint.dateFormat = "cccc"

    let localeDate = dateFormatterGet.date(from: date)
    return dateFormatterPrint.string(from: localeDate!)
  }

  static func parseForecastDetails(json: JSON) -> [WeatherForecast] {

    var results = [WeatherForecast]()

    let forecastDeets = json["list"].arrayValue
    forecastDeets.forEach { each in

      let weatherDate = each["dt_txt"].stringValue
      let theDate = self.convertUtcToLocalTime(date: weatherDate)
      let icon = each["weather"][0]["icon"].stringValue
      let maxTemp = each["main"]["temp_max"].doubleValue


      let forecastObject = WeatherForecast(dailyTemp: maxTemp, dailyDate: theDate, dailyIcon: icon)
      
      if results.contains( where: { $0.dailyDate == forecastObject.dailyDate } ) == false {
            results.append(forecastObject)
         } 
    }
    return results
  }
}
