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
    @State var selectedImage: NamedImage?

    var body: some View {
        List {
            Section {
                ForEach(theme.images.keys, id: \.self) { key in
                    let image: Image = theme.images[dynamicMember: key]
                    LabeledContent(
                        key,
                        content: {
                            Button {
                                selectedImage = .init(name: key, image: image)
                            } label: {
                                image
                                    .resizable()
                                    .frame(width: 24, height: 24)
                                    .scaledToFit()
                            }

                        })
                }
            }
        }
        .navigationTitle("Images")
        .navigationBarTitleDisplayMode(.inline)
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
