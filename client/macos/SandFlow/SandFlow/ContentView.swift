//
//  ContentView.swift
//  SandFlow
//
//  Created by 木本瑛介 on 2026/05/28.
//

import SwiftUI

struct ContentView: View {
    @State private var isSidebarOpen = true
    @State private var selectedSection: SidebarSection = .createTask

    var body: some View {
        RootContainerRepresentable(isSidebarOpen: isSidebarOpen) {
            SidebarView(isSidebarOpen: $isSidebarOpen, selectedSection: $selectedSection)
        } mainContent: {
            MainContentView(isSidebarOpen: $isSidebarOpen, selectedSection: $selectedSection)
        }
        .ignoresSafeArea()
    }
}

#Preview {
    ContentView()
}
