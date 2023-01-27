//
//  SwiftUI+.swift
//  BlueMediaHelpSearch
//
//  Created by Kamil Chlebuś on 25/01/2023.
//

import SwiftUI

extension Text {
  init(_ string: String, configure: ((inout AttributedString) -> Void)) {
    var attributedString = AttributedString(string)
    configure(&attributedString)
    self.init(attributedString)
  }
}

extension Color {
  init(asset colorAsset: ColorAsset) {
    self.init(colorAsset.rawValue)
  }
}

extension Image {
  init(asset imageAsset: ImageAsset) {
    self.init(imageAsset.rawValue)
  }
}
