//
//  ContentView.swift
//  SandFlow
//
//  Created by 木本瑛介 on 2026/05/28.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        RootContainerRepresentable {
            SidebarView()
        } mainContent: {
            MainContentView()
        }
        .ignoresSafeArea()
    }
}

#Preview {
    ContentView()
}
