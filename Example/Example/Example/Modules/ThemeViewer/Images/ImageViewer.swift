//
//  ImageViewer.swift
//  Example
//
//  Created by Volodymyr Voiko on 05.12.2024.
//

import SwiftUI

struct NamedImage: Identifiable {
    var id: String { name }

    let name: String
    let image: Image
}

struct ImageViewer: View {
    @Environment(\.dismiss) var dismiss
    @Environment(Theme.self) private var theme

    let namedImage: NamedImage

    var body: some View {
        NavigationStack {
            ZStack {
                namedImage.image
                    .renderingMode(.template)
                    .resizable()
                    .scaledToFit()
                    .foregroundStyle(theme.colors.primary)
            }
            .padding()
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button {
                        dismiss()
                    } label: {
                        Text("Close")
                    }
                }
            }
            #if os(iOS) || targetEnvironment(macCatalyst)
                .navigationBarTitleDisplayMode(.inline)
            #endif
            .navigationTitle(namedImage.name)
        }
    }
}
