//
//  Webservice.swift
//  WeatherApp
//
//  Created by Grace Njoroge on 14/10/2020.
//  Copyright © 2020 Grace. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

public class WebService {

  static func getForecast(_ params: [String: String], completion: @escaping (JSON) -> Void) {

    let requestName = "GetForecast"

    AF.request("https://api.openweathermap.org/data/2.5/forecast", method: .get, parameters: params).responseJSON { response in

      switch response.result {

      case .success:
        do {
          let jsonData =  try JSON(data: response.data!)
          completion(jsonData)
        } catch  {
          print("Error in catch \(requestName) \(error)")
        }

        print("\(requestName) Success!")


      case .failure(let error):
        print(requestName, error.localizedDescription)

      }
    }
  }

  static func getWeather(_ params: [String: String], completion: @escaping (JSON) -> Void) {

    let requestName = "GetWeather"

    AF.request("https://api.openweathermap.org/data/2.5/weather", method: .get, parameters: params).responseJSON { response in

      switch response.result {

      case .success:
        do {
          let jsonData =  try JSON(data: response.data!)
          completion(jsonData)
        } catch  {
          print("Error in catch \(requestName) \(error)")
        }

        print("\(requestName) Success!")


      case .failure(let error):
        print(requestName, error.localizedDescription)

      }
    }
  }
}
