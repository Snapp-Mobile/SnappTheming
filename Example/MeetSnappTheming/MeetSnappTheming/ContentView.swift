//
//  ContentView.swift
//  MeetSnappTheming
//
//  Created by Volodymyr Voiko on 11.02.2025.
//

import SnappTheming
import SwiftUI

struct ContentView: View {
    let theme: SnappThemingDeclaration = .light

    var body: some View {
        ThemeDeclarationView()
    }
}

#Preview {
    ContentView()
}
