//
//  SearchResultRow.swift
//  BlueMediaHelpSearch
//
//  Created by Kamil Chlebuś on 25/01/2023.
//

import SwiftUI

struct SearchResultRow: View {
  let article: Article

  var body: some View {
    VStack(alignment: .leading, spacing: 10) {
      Link(destination: article.link) {
        Text(article.title)
          .underline()
          .multilineTextAlignment(.leading)
      }
      .tint(Color.black)
      .font(.system(size: 20, weight: .semibold))

      Text(article.preview)
        .lineLimit(2)
        .foregroundColor(.gray)
        .font(.system(size: 16, design: .serif))
    }
    .padding(.horizontal, 20)
  }
}

struct SearchResultRow_Previews: PreviewProvider {
  static var previews: some View {
    SearchResultRow(article: Article(
      id: 1072,
      title: "Bezpieczeństwo - o czym pamiętać płacąc online?",
      link: URL(string: "https://pomoc.bluemedia.pl/bezpieczenstwo/o-czym-pamietac-placac-online")!,
      preview: "Płatności online to nie tylko zakupy przez internet. To również płatności za rachunki, doładowania telefonów, zakup dostępu do usług multimedialnych i wiele innych. Ty również pewnie większość należności opłacasz online, zgadza się? Jako dostawca bramki płatniczej dbamy o to, ż")
    )
    .previewLayout(.sizeThatFits)
  }
}
