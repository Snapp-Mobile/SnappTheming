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
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding()
            .background(Color.indigo)

            VStack {
                Group {
                    Text("Headline")
                    Text("Subheadline")
                    Text("Body")
                }
                .frame(maxWidth: .infinity, alignment: .leading)

                Spacer()

                Button {
                } label: {
                    Label("Button", systemImage: "pencil.and.ruler.fill")
                }
            }
            .padding()
        }
        .tint(Color.red)
    }
}

#Preview {
    ThemeDeclarationView(theme: .light)
}
