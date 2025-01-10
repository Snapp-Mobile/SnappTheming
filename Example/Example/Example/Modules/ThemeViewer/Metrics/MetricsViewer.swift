//
//  MetricsViewer.swift
//  Example
//
//  Created by Volodymyr Voiko on 03.12.2024.
//

import SwiftUI
import SnappTheming

struct SpacingMetricView: View {
    let metric: CGFloat

    var body: some View {
        HStack {
            Rectangle()
                .frame(width: metric, height: 4)
                .foregroundStyle(Color.accentColor)
        }
    }
}

struct CornerRadiusMetricView: View {
    let metric: CGFloat

    var body: some View {
        Rectangle()
            .foregroundStyle(Color.accentColor)
            .frame(width: 40, height: 40)
            .clipShape(.rect(topTrailingRadius: metric))
    }
}

struct MetricsViewer: View {
    let declarations: SnappThemingMetricDeclarations

    var body: some View {
        List {
            section("Spacing") { metric in
                SpacingMetricView(metric: metric)
            }

            section("Corner radius") {metric in
                CornerRadiusMetricView(metric: metric)
            }
        }
        .navigationTitle("Metrics")
        .navigationBarTitleDisplayMode(.inline)
    }

    func section<V>(_ title: String, content: @escaping (CGFloat) -> V) -> some View where V: View {
        Section(title) {
            ForEach(declarations.keys, id: \.self) { key in
                HStack {
                    let metric: CGFloat = declarations[dynamicMember: key]
                    VStack {
                        Text(key)
                            .font(.body)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Text(String(describing: metric))
                            .font(.caption)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    content(metric)
                }
            }
        }
    }
}

#Preview {
    NavigationView {
        MetricsViewer(declarations: SnappThemingDeclaration.preview.metrics)
    }
}
