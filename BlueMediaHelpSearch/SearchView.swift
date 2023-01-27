//
//  SearchView.swift
//  BlueMediaHelpSearch
//
//  Created by Kamil Chlebuś on 25/01/2023.
//

import SwiftUI


struct SearchScene: View {
  @State var searchText: String = ""

  private let horizontalPadding: CGFloat = 20

  var body: some View {
    VStack {
      HStack() {
        Image("blue-media-logo")
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

      SearchTextField(searchText: $searchText)

      Spacer()
    }
    .padding(horizontalPadding)
  }

}

struct SearchView_Previews: PreviewProvider {
  static var previews: some View {
    SearchScene()
  }
}
