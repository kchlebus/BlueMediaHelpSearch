//
//  BlueMediaHelpSearchApp.swift
//  BlueMediaHelpSearch
//
//  Created by Kamil Chlebuś on 25/01/2023.
//

import SwiftUI

@main
struct BlueMediaHelpSearchApp: App {
  @StateObject private var searchApiService: SearchApiService

  init() {
    _searchApiService = StateObject(
      wrappedValue: SearchApiService(baseUrl: Networking.baseUrl, session: Networking.baseSession)
    )
  }

  var body: some Scene {
    WindowGroup {
      SearchScene()
        .preferredColorScheme(.light)
        .environmentObject(searchApiService)
    }
  }
}
