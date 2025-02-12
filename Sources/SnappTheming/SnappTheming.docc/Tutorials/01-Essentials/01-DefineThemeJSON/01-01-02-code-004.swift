import SnappTheming
import SwiftUI

struct ThemeDeclarationView: View {
    let theme: SnappThemingDeclaration

    var body: some View {
        VStack(spacing: 0) {
            VStack {
                Group {
                    Text("Large Title")
                    Text("Title")
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
                    Text("Subheadline")
                        .foregroundStyle(theme.colors.textSecondary)
                    Text("Body")
                        .foregroundStyle(theme.colors.textPrimary)
                }
                .frame(maxWidth: .infinity, alignment: .leading)

                Spacer()

                Button {} label: {
                    Label("Button", systemImage: "pencil.and.ruler.fill")
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
