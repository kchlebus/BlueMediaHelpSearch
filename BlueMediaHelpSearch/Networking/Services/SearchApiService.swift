//
//  BlueMediaAPIService.swift
//  BlueMediaHelpSearch
//
//  Created by Kamil Chlebuś on 26/01/2023.
//

import Foundation

final class SearchApiService: ObservableObject {
  let baseUrl: URL
  let session: URLSession

  init(baseUrl: URL, session: URLSession = URLSession.shared) {
    self.baseUrl = baseUrl
    self.session = session
  }

  func searchArticle(query: String, pageNumber: Int, pageSize: Int) async throws -> SearchResponse {
    var components = URLComponents()
    components.path = "/search-engine/search"
    components.queryItems = [
      URLQueryItem(name: "query", value: query),
      URLQueryItem(name: "per-page", value: "\(pageSize)"),
      URLQueryItem(name: "page", value: "\(pageNumber)"),
      URLQueryItem(name: "mode", value: "1")
    ]
    guard let url = components.url(relativeTo: baseUrl) else {
      throw URLError(.badURL)
    }

    var request = URLRequest(url: url)
    request.addValue("application/json", forHTTPHeaderField: "Accept")
    request.httpMethod = "GET"

    let (data, _) = try await session.data(for: request)
    let searchResponse = try JSONDecoder().decode(SearchResponse.self, from: data)

    return searchResponse
  }
}
