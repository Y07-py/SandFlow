//
//  SandFlowApp.swift
//  SandFlow
//
//  Created by 木本瑛介 on 2026/05/28.
//

import SwiftUI

@main
struct SandFlowApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .ignoresSafeArea(edges: .top)
        }
        .windowStyle(.hiddenTitleBar)
    }
}
