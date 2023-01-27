//
//  SearchView.swift
//  BlueMediaHelpSearch
//
//  Created by Kamil Chlebuś on 25/01/2023.
//

import SwiftUI

struct SearchScene: View {
  @EnvironmentObject private var searchApiService: SearchApiService

  @State private var searchText: String = ""
  @State private var currentQuery: String = ""
  @State private var articles: [Article] = []

  @State private var isErrorAlertPresented: Bool = false
  @State private var isLoadingNewQuery: Bool = false

  private var paging: Paging = Paging(pageSize: 10, pageNumber: 1)
  private let horizontalPadding: CGFloat = 20

  var body: some View {
    VStack {
      Group {
        HStack {
          Image(asset: .blueMediaLogo)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(maxWidth: 80)
          Spacer()
        }

        Divider()
          .padding(.horizontal, -horizontalPadding)

        Text("Jakich informacji szukasz?") { string in
          if let range = string.range(of: "informacji") {
            string[range].foregroundColor = .orange
          }
        }
        .font(.title2)
        .fontWeight(.medium)
        .padding(.vertical, 20)

        SearchTextField(text: $searchText)
          .padding(.bottom, 10)
          .onSubmit {
            guard currentQuery != searchText else { return }
            self.articles = []
            self.currentQuery = searchText
            self.paging.reset(startPageNumber: 1)
            Task {
              self.isLoadingNewQuery = true
              await sendSearchRequest(query: searchText)
              self.isLoadingNewQuery = false
            }
          }

        if isLoadingNewQuery {
          ProgressView()
            .padding(.top, 30)
        }
      }
      .padding(.horizontal, horizontalPadding)

      searchResultsList()
    }
    .ignoresSafeArea(edges: .bottom)
    .alert(isPresented: $isErrorAlertPresented) {
      Alert(
        title: Text("Wystąpił błąd"),
        message: Text("Spróbuj ponownie lub skontaktuj się z naszym działem pomocy."),
        dismissButton: .default(Text("Ok"))
      )
    }
  }

  func searchResultsList() -> some View {
    List(Array(articles.enumerated()), id: \.element.id) { index, article in
      SearchResultRow(article: article)
        .listRowInsets(EdgeInsets(top: 20, leading: 0, bottom: 20, trailing: 0))
        .alignmentGuide(.listRowSeparatorLeading) { _ in 0 }
        .onAppear {
          Task {
            await loadNextPage(index: index)
          }
        }
    }
    .padding(.bottom, 20)
    .listStyle(.plain)
    .buttonStyle(PlainButtonStyle())
    .scrollDismissesKeyboard(.immediately)
  }
}

private extension SearchScene {
  func sendSearchRequest(query: String) async {
    do {
      let response = try await searchApiService.searchArticle(
        query: query,
        pageNumber: paging.pageNumber,
        pageSize: paging.pageSize
      )
      paging.totalPages = response._meta.totalCount
      articles.append(contentsOf: response.items.map(Article.init))
    } catch {
      isErrorAlertPresented = true
      debugPrint(error)
    }
  }

  func loadNextPage(index: Int) async {
    let articlesCount = articles.count
    let thresholdIndex = (articlesCount - 1) - 4
    if articlesCount < paging.totalPages && thresholdIndex == index {
      paging.pageNumber += 1
      await sendSearchRequest(query: currentQuery)
    }
  }
}

struct SearchView_Previews: PreviewProvider {
  static var previews: some View {
    SearchScene()
  }
}
