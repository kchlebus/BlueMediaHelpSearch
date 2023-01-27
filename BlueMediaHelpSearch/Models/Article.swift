//
//  Article.swift
//  BlueMediaHelpSearch
//
//  Created by Kamil Chlebuś on 26/01/2023.
//

import Foundation

struct Article: Identifiable {
  let id: Int
  let title: String
  let link: URL
  let preview: String
}

extension Article {
  init(from response: ArticleResponse) {
    self.id = response.id
    self.title = response.title
    self.link = response.link
    self.preview = response.preview
  }
}
