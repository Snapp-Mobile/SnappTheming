//
//  LabelExtensions.swift
//  Example
//
//  Created by Volodymyr Voiko on 31.01.2025.
//

import SwiftUI

extension Label where Title == Text, Icon == Image {
    init(_ text: String, icon: Image) {
        self.init(title: { Text(text) }, icon: { icon })
    }
}
