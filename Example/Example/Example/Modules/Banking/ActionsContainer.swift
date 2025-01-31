//
//  ActionsContainer.swift
//  Example
//
//  Created by Volodymyr Voiko on 29.01.2025.
//

import SwiftUI

struct ActionsContainer<Content: View>: View {
    struct Item {
        let index: Int
        let subview: Subview
    }
    @ViewBuilder var content: Content
    var body: some View {
        HStack(spacing: 0) {
            ForEach(
                sections: content,
                content: { section in
                    let items = section.content.enumerated().map(Item.init(index:subview:))
                    ForEach(items, id: \.index) { item in
                        item.subview
                        if item.index != section.content.endIndex - 1 {
                            Spacer()
                        }
                    }
                })
        }
        .padding(.horizontal, 7)
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    ActionsContainer {
        Button(action: {}) {
            Label("Title 1", systemImage: "xmark")
        }
        Button(action: {}) {
            Label("Title 2", systemImage: "xmark")
        }
        Button(action: {}) {
            Label("Title 3", systemImage: "xmark")
        }
    }
    .buttonStyle(.actionButton)
}
