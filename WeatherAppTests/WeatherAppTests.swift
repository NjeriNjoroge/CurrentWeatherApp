//
//  WeatherAppTests.swift
//  WeatherAppTests
//
//  Created by Grace Njoroge on 15/10/2020.
//  Copyright © 2020 Grace. All rights reserved.
//

import XCTest
import SwiftyJSON
@testable import WeatherApp



class WeatherAppTests: XCTestCase {

  let expectation = XCTestExpectation()
  var sut: MainViewController!

  override func setUpWithError() throws {
    sut = MainViewController()
    sut.loadViewIfNeeded()
  }

  override func tearDownWithError() throws {
    sut = nil
  }

}

extension WeatherAppTests {

  func testApiWeatherEndPointWorks() {
    let exp = self.expectation(description: "get weather")
    let params = ["lat": "55.7", "lon": "37.6", "appid": ""]
    WebService.getWeather(params) { (json) in
      if json == nil {
        XCTFail()
      }
      // The request is finished, so our expectation
     exp.fulfill()
    }
    // We ask the unit test to wait our expectation to finish.
    self.waitForExpectations(timeout: 20)
  }

  func testApiForecastEndPointWorks() {
    
    let exp = self.expectation(description: "get forecast")
    let params = ["lat": "55.7", "lon": "37.6", "appid": "0fd65ae8051cec4f21c386659c25955b"]
    WebService.getForecast(params) { (json) in
      if json == nil {
        XCTFail()
      } 
      // The request is finished, so our expectation
     exp.fulfill()
    }
    // We ask the unit test to wait our expectation to finish.
    self.waitForExpectations(timeout: 20)

  }

  func testDateConversion() {
    let dateFromJson = "2020-10-16 09:00:00"
    let convertedDate = Parse.convertUtcToLocalTime(date: dateFromJson)
    XCTAssertNotEqual(dateFromJson, convertedDate)
  }

  func testWeatherModelStruct_canCreateNewInstance() {
      let structData = WeatherForecast(dailyTemp: 22.91, dailyDate: "2016-08-14 18:00:00", dailyIcon: "01d")
      XCTAssertNotNil(structData)
   }

}

