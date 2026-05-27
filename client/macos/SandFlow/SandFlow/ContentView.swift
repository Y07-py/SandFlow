//
//  ContentView.swift
//  SandFlow
//
//  Created by 木本瑛介 on 2026/05/28.
//

import SwiftUI

struct ContentView: View {
    @State private var isSidebarOpen = true

    var body: some View {
        RootContainerRepresentable(isSidebarOpen: isSidebarOpen) {
            SidebarView(isSidebarOpen: $isSidebarOpen)
        } mainContent: {
            MainContentView(isSidebarOpen: $isSidebarOpen)
        }
        .ignoresSafeArea()
    }
}

#Preview {
    ContentView()
}
