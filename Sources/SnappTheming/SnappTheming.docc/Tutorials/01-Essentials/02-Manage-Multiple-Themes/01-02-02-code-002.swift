import SnappTheming
import SwiftUI

struct ThemeDeclarationView: View {
    @State var theme: SnappThemingDeclaration = .light

    var body: some View {
        VStack(spacing: 0) {
            VStack {
                Group {
                    Text("Large Title")
                        .font(theme.typography.largeTitle)
                    Text("Title")
                        .font(theme.typography.title)
                }
                .foregroundStyle(theme.colors.textPrimary)
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding()
            .background(theme.colors.surfaceSecondary)

            VStack {
                Group {
                    Text("Headline")
                        .foregroundStyle(theme.colors.textPrimary)
                        .font(theme.typography.headline)
                    Text("Subheadline")
                        .foregroundStyle(theme.colors.textSecondary)
                        .font(theme.typography.subheadline)
                    Text("Body")
                        .foregroundStyle(theme.colors.textPrimary)
                        .font(theme.typography.body)
                }
                .frame(maxWidth: .infinity, alignment: .leading)

                Spacer()

                HStack {
                    Button {
                    } label: {
                        Label("Light Theme", systemImage: "lightbulb.fill")
                            
                    }

                    Button {
                    } label: {
                        Label("Dark Theme", systemImage: "lightbulb")
                    }
                }
                .font(theme.typography.body)
            }
            .padding()
            .background(theme.colors.surfacePrimary)
        }
        .tint(theme.colors.primary)
    }
}

#Preview {
    ThemeDeclarationView()
}
