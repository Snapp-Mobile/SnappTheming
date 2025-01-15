//
//  GradientView.swift
//  Example
//
//  Created by Ilian Konchev on 15.01.25.
//

import SwiftUI

struct GradientView<Shape: ShapeStyle>: View {
    let style: Shape

    var body: some View {
        RoundedRectangle(cornerRadius: 4)
            .frame(width: 120, height: 48)
            .foregroundStyle(style)
    }
}
