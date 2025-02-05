//
//  ThemedView.swift
//  Example
//
//  Created by Ilian Konchev on 21.11.24.
//

import OSLog
import SnappTheming
import SnappThemingSwiftUIHelpers
import SwiftUI

#if !os(watchOS)
    import Lottie
#endif

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

    @ViewBuilder
    var fonts: some View {
        Text("Light")
            .font(declaration.fonts.light.font(size: 18))

        Text("Regular")
            .font(declaration.fonts.default.font(size: 18))

        Text("Medium")
            .font(declaration.fonts.medium.font(size: 18))

        Text("Bold")
            .font(declaration.fonts.bold.font(size: 18))
    }

    var body: some View {
        ScrollView {
            VStack {
                Progress(declaration: declaration, progress: 58, limit: 75)

                RoundedRectangle(cornerRadius: regular)
                    .fill(declaration.colors.primary)
                    .overlay {
                        declaration.images.bigIcon
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: 200, idealHeight: 200)
                    }
                    .frame(maxWidth: 200, idealHeight: 200)
                    .padding()

                #if !os(watchOS)
                    LottieView.init(animation: try? .from(data: declaration.animations.lego.data))
                        .playing()
                        .frame(width: 100, height: 100)
                #endif

                Text("Title typography")
                    .font(declaration.typography.titleLarge)
                    .foregroundStyle(declaration.colors.textPrimary)

                Text("Body typography")
                    .font(declaration.typography.textMedium)
                    .foregroundStyle(declaration.colors.textSecondary)
                    .padding(.vertical, 8)

                ViewThatFits(content: {
                    HStack {
                        fonts
                    }

                    VStack {
                        fonts
                    }
                })
                .foregroundStyle(declaration.colors.textPrimary)
                .padding(.top, 8)

                HStack {
                    Button {

                    } label: {
                        Image(systemName: "music.note.house.fill")
                            .frame(minWidth: 64, minHeight: 64)
                    }
                    .buttonStyle(declaration.buttonStyles.primary, selected: declaration.buttonStyles.primarySelected)
                    .selected(isSelected)
                    #if !os(tvOS)
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
                    #endif

                    Button {
                        Task {
                            isButtonEnabled = false
                            try await Task.sleep(for: .seconds(2))
                            isButtonEnabled = true
                        }
                    } label: {
                        Text("123")
                            .frame(minWidth: 64, minHeight: 64)
                    }
                    .disabled(!isButtonEnabled)
                    .buttonStyle(declaration.buttonStyles.primaryBrand)
                }
            }
            .padding(.horizontal)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            declaration.gradients.appBackground
        )
    }
}
