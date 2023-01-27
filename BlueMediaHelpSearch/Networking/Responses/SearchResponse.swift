//
//  SearchResponse.swift
//  BlueMediaHelpSearch
//
//  Created by Kamil Chlebuś on 26/01/2023.
//

import Foundation

struct SearchResponse: Decodable {
  let items: [ArticleResponse]
  let _meta: SearchMetaResponse
}

struct ArticleResponse: Decodable {
  let id: Int
  let title: String
  let link: URL
  let preview: String

  enum CodingKeys: CodingKey {
    case id
    case title
    case link
    case preview
  }

  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    id = try container.decode(Int.self, forKey: .id)
    title = try container.decode(String.self, forKey: .title)

    let articlePath = try container.decode(String.self, forKey: .link)
    link = Networking.baseUrl.appending(path: articlePath)

    let previewJsonString = try container.decode(String.self, forKey: .preview)
    let data = previewJsonString.data(using: .utf8) ?? Data()
    let articlePreview = try? JSONDecoder().decode(ArticlePreview.self, from: data)

    preview = articlePreview?.text.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
  }
}

struct ArticlePreview: Decodable {
  let text: String
}

struct SearchMetaResponse: Decodable {
  let totalCount: Int
  let pageCount: Int
  let currentPage: Int
  let perPage: Int
}
