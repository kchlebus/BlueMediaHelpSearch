//
//  AppConstants.swift
//  BlueMediaHelpSearch
//
//  Created by Kamil Chlebuś on 26/01/2023.
//

import Foundation

enum Networking {
  static let baseUrl = URL(string: "https://pomoc.bluemedia.pl")!
  static var baseSession: URLSession {
    let configuration = URLSessionConfiguration.default
    configuration.timeoutIntervalForRequest = 10.0
    let session = URLSession(configuration: configuration)
    return session
  }

  enum Routes {
    static let search = "/search-engine/search"
  }
}

enum ImageAsset: String {
  case blueMediaLogo = "blue-media-logo"
}

enum ColorAsset: String {
  case blueMedia = "BlueMedia"
  case lightGray = "LightGray"
}
