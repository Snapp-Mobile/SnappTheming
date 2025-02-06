//
//  ImagesViewer.swift
//  Example
//
//  Created by Ilian Konchev on 4.12.24.
//

import SnappTheming
import SwiftUI

struct ImagesViewer: View {
    @Environment(Theme.self) private var theme
    @FocusState var focusedKey: String?
    @State var selectedImage: NamedImage?

    var body: some View {
        List {
            Section {
                ForEach(theme.images.keys, id: \.self) { key in
                    let image: Image = theme.images[dynamicMember: key]
                    LabeledContent(
                        content: {
                            Button {
                                selectedImage = .init(name: key, image: image)
                            } label: {
                                image
                                    .resizable()
                                    .frame(width: 24, height: 24)
                                    .scaledToFit()
                            }
                            .scaleEffect(focusedKey == key ? 1.2 : 1.0)
                        },
                        label: {
                            Text(key)
                                .foregroundStyle(focusedKey == key ? Color.accentColor : .primary)
                        }
                    )
                    .focusable(true)
                    .focused($focusedKey, equals: key)
                }
            }
        }
        .navigationTitle("Images")
        #if os(iOS) || targetEnvironment(macCatalyst)
            .navigationBarTitleDisplayMode(.inline)
        #endif
        .sheet(item: $selectedImage) {
            ImageViewer(namedImage: $0)
        }
    }
}

#Preview {
    NavigationView {
        ImagesViewer()
            .environment(Theme(.default))
    }
}
