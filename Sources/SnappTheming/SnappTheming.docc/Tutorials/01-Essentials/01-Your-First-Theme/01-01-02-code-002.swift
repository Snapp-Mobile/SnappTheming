import SnappTheming
import SwiftUI

struct ThemeDeclarationView: View {
    let theme: SnappThemingDeclaration

    var body: some View {
        EmptyView()
    }
}

#Preview {
    ThemeDeclarationView(theme: .light)
}
