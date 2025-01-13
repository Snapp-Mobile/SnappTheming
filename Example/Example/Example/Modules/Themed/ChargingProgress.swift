//
//  ChargingProgress.swift
//  Example
//
//  Created by Oleksii Kolomiiets on 05.12.2024.
//

import SnappTheming
import SwiftUI

struct ChargingProgress: View {
    var declaration: SnappThemingDeclaration
    @State var progress: Int
    @State var limit: Int

    var body: some View {
        ZStack(alignment: .leading) {
            GeometryReader { geometry in
                RoundedRectangle(cornerRadius: declaration.metrics.windowRadiusSmall)
                    .fill(Color(hex: "#FFFFFF", alpha: 0.06))
                    .shadow(color: Color(hex: "#000000", alpha: 0.16), radius: 16, x: 0, y: 16)

                RoundedRectangle(cornerRadius: declaration.metrics.windowRadiusSmall)
                    .strokeBorder(
                        Color(hex: "#0FA1CB"),
                        style: StrokeStyle(lineWidth: 1, lineCap: .round, dash: [2, 2])
                    )
                    .frame(width: limitWidth(containerWidth: geometry.size.width))

                RoundedRectangle(cornerRadius: declaration.metrics.windowRadiusSmall)
                    .fill(
                        declaration.shapeStyle.chargingProgress
                    )
                    .shadow(color: Color(hex: "#000000", alpha: 0.2), radius: 20, x: 0, y: 4)
                    .frame(width: progressWidth(containerWidth: geometry.size.width))
                HStack {
                    Group {
                        declaration.images.basket
                            .resizable()
                            .frame(width: 20, height: 22)
                            .font(declaration.typography.titleMediumSemiBold.font)
                            .foregroundStyle(declaration.colors.surfaceTertiary)
                        HStack(alignment: .lastTextBaseline, spacing: 4) {
                            Text("\(progress)")
                                .font(declaration.fonts.bold.font(size: 24))
                            Text("%")
                                .font(declaration.typography.textSmall.font)
                        }
                    }
                    .foregroundStyle(declaration.colors.surfaceTertiary)

                    Spacer()
                }
                .frame(height: geometry.size.height)
                .padding(.horizontal, 12)
            }
        }
        .frame(height: 57)
        .padding()
    }

    func limitWidth(containerWidth: CGFloat) -> CGFloat {
        containerWidth * Double(limit) / 100.0
    }

    func progressWidth(containerWidth: CGFloat) -> CGFloat {
        containerWidth * Double(progress) / 100.0
    }
}

