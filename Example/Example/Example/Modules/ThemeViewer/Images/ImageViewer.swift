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
    let namedImage: NamedImage

    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationStack {
            ZStack {
                namedImage.image
                    .resizable()
                    .scaledToFit()
                    .foregroundStyle(Color.accentColor)
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
