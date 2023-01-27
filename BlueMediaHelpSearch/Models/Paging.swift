//
//  Paging.swift
//  BlueMediaHelpSearch
//
//  Created by Kamil Chlebuś on 27/01/2023.
//

final class Paging {
  let pageSize: Int
  var pageNumber: Int
  var totalPages: Int = 0

  init(pageSize: Int, pageNumber: Int) {
    self.pageSize = pageSize
    self.pageNumber = pageNumber
  }

  func reset(startPageNumber: Int) {
    self.pageNumber = startPageNumber
    self.totalPages = 0
  }
}
