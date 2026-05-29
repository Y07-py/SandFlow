//
//  RootContainerRepresentable.swift
//  SandFlow
//
//  Created by 木本瑛介 on 2026/05/28.
//

import SwiftUI
import AppKit

struct RootContainerRepresentable<Sidebar: View, MainContent: View>: NSViewControllerRepresentable {

    private let isSidebarOpen: Bool
    private let sidebar: Sidebar
    private let mainContent: MainContent

    init(
        isSidebarOpen: Bool,
        @ViewBuilder sidebar: () -> Sidebar,
        @ViewBuilder mainContent: () -> MainContent
    ) {
        self.isSidebarOpen = isSidebarOpen
        self.sidebar = sidebar()
        self.mainContent = mainContent()
    }

    func makeNSViewController(context: Context) -> RootContainerViewController {
        let sidebarHosting = NSHostingView(rootView: sidebar)
        let mainHosting = NSHostingView(rootView: mainContent)
        sidebarHosting.translatesAutoresizingMaskIntoConstraints = false
        mainHosting.translatesAutoresizingMaskIntoConstraints = false
        return RootContainerViewController(
            sidebarHostingView: sidebarHosting,
            mainContentHostingView: mainHosting
        )
    }

    func updateNSViewController(_ nsViewController: RootContainerViewController, context: Context) {
        (nsViewController.sidebarHostingView as? NSHostingView<Sidebar>)?.rootView = sidebar
        (nsViewController.mainContentHostingView as? NSHostingView<MainContent>)?.rootView = mainContent
        nsViewController.setSidebarOpen(isSidebarOpen)
    }
}
