//
//  UIImageExt.swift
//  WeatherApp
//
//  Created by Grace Njoroge on 15/10/2020.
//  Copyright © 2020 Grace. All rights reserved.
//

import UIKit

extension UIImage {
  convenience init?(url: URL?) {
    guard let url = url else { return nil }

    do {
      self.init(data: try Data(contentsOf: url))
    } catch {
      print("Cannot load image from url: \(url) with error: \(error)")
      return nil
    }
  }
}
