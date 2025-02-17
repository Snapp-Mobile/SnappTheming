import SnappTheming
import SwiftUI

struct ThemeDeclarationView: View {
    let theme: SnappThemingDeclaration

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

                Button {
                } label: {
                    Label("Button", systemImage: "pencil.and.ruler.fill")
                        .font(theme.typography.body)
                }
            }
            .padding()
            .background(theme.colors.surfacePrimary)
        }
        .tint(theme.colors.primary)
    }
}

#Preview {
    ThemeDeclarationView(theme: .light)
}
