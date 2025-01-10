//
//  ThemedView.swift
//  Example
//
//  Created by Ilian Konchev on 21.11.24.
//

import SnappTheming
import SwiftUI
import OSLog

struct ThemedView: View {
    var declaration: SnappThemingDeclaration
    @ScaledMetric var regular = 0.0

    @State var isButtonEnabled: Bool = true
    @State var isSelected: Bool = false
    @State private var isPressed = false

    init(declaration: SnappThemingDeclaration) {
        self.declaration = declaration
        _regular = .init(wrappedValue: declaration.metrics.windowRadiusSmall)
    }
    
    var body: some View {
        VStack {
            ChargingProgress(declaration: declaration, progress: 58, distance: 312, limit: 75)

            RoundedRectangle(cornerRadius: regular)
                .fill(declaration.colors.primary)
                .overlay {
                    declaration.images.bigIcon
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200, height: 200)
                }
                .frame(width: 200, height: 200)
                .padding()

            Text("Title typography")
                .font(declaration.typography.titleLarge)
                .foregroundStyle(declaration.colors.textPrimary)

            Text("Body typography")
                .font(declaration.typography.textMedium)
                .foregroundStyle(declaration.colors.textSecondary)

            HStack {
                Text("Light")
                    .font(declaration.fonts.light.font(size: 18))

                Text("Regular")
                    .font(declaration.fonts.default.font(size: 18))

                Text("Medium")
                    .font(declaration.fonts.medium.font(size: 18))

                Text("Bold")
                    .font(declaration.fonts.bold.font(size: 18))
            }
            .foregroundStyle(declaration.colors.textPrimary)
            .padding(.top, 8)

            HStack {
                Button {

                } label: {
                    Image(systemName: "music.note.house.fill")
                }
                .buttonStyle(AppButtonStyle(selected: isSelected, style: declaration.buttonStyles.primary, width: 64))
                .simultaneousGesture(
                    DragGesture(minimumDistance: 0)
                        .onChanged { _ in
                            if !isPressed {
                                isPressed = true
                                print("Button pressed")
                            }
                        }
                        .onEnded { _ in
                            if isPressed {
                                isSelected.toggle()
                                isPressed = false
                                print("Button released")
                            }
                        }
                )

                Button {
                    Task {
                        isButtonEnabled = false
                        try await Task.sleep(for: .seconds(2))
                        isButtonEnabled = true
                    }
                } label: {
                    Text("123")
                }
                .disabled(!isButtonEnabled)
                .buttonStyle(AppButtonStyle(style: declaration.buttonStyles.primaryBrand, width: 64))
            }

        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            declaration.shapeStyle.appBackground
        )
    }
}
