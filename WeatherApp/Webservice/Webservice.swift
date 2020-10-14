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

static func getForecast(completion: @escaping (JSON) -> Void) {

  let requestName = "GetForecast"
  let params = ["lon": "36.82", "lat": "-1.28", "appid": "0fd65ae8051cec4f21c386659c25955b"]


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
}
