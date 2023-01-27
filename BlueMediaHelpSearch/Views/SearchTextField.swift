//
//  SearchTextField.swift
//  BlueMediaHelpSearch
//
//  Created by Kamil Chlebuś on 25/01/2023.
//

import SwiftUI

struct SearchTextField: View {
  @Binding var text: String
  @FocusState private var isFocused: Bool

  var body: some View {
    HStack(spacing: 10) {
      HStack(spacing: 15) {
        Image(systemName: "magnifyingglass")
          .resizable()
          .frame(width: 20, height: 20)
          .foregroundColor(Color(asset: .blueMedia))

        TextField("Wpisz np. doładowanie faktura", text: $text)
          .tint(Color.black)
          .submitLabel(.search)
          .focused($isFocused)
      }
      .padding(.vertical, 15)

      if !text.isEmpty {
        Button {
          self.text = ""
          self.isFocused = true
        } label: {
          Image(systemName: "multiply.circle")
          .resizable()
          .aspectRatio(contentMode: .fill)
          .foregroundColor(Color.gray)
          .frame(width: 20, height: 20)
        }
        .frame(width: 35, height: 35)
      }
    }
    .padding(.leading, 20)
    .padding(.trailing, 15)
    .background {
      Capsule()
        .fill(Color.white)
        .shadow(color: Color(asset: .lightGray), radius: 8, x: 0, y: 4)
    }
  }
}

struct SearchTextField_Previews: PreviewProvider {
  static var previews: some View {
    SearchTextField(text: .constant("Faktury"))
      .previewLayout(.sizeThatFits)
      .padding()
  }
}
