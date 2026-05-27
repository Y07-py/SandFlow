//
//  RootContainerViewController.swift
//  SandFlow
//
//  Created by 木本瑛介 on 2026/05/28.
//

import AppKit
import SwiftUI

final class RootContainerViewController: NSViewController {

    private static let backgroundColor = NSColor(
        srgbRed: 0.1, green: 0.15, blue: 0.2, alpha: 1.0
    )
    private static let defaultSidebarWidth: CGFloat = 220

    private let sidebarContainer = NSSidebarView()
    private let mainContentContainer = NSMainContentView()
    private var sidebarWidthConstraint: NSLayoutConstraint!

    let sidebarHostingView: NSView
    let mainContentHostingView: NSView

    init(sidebarHostingView: NSView, mainContentHostingView: NSView) {
        self.sidebarHostingView = sidebarHostingView
        self.mainContentHostingView = mainContentHostingView
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        let container = NSView()
        container.wantsLayer = true
        container.layer?.backgroundColor = Self.backgroundColor.cgColor

        container.addSubview(sidebarContainer)
        container.addSubview(mainContentContainer)

        sidebarWidthConstraint = sidebarContainer.widthAnchor.constraint(
            equalToConstant: Self.defaultSidebarWidth
        )

        NSLayoutConstraint.activate([
            sidebarContainer.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            sidebarContainer.topAnchor.constraint(equalTo: container.topAnchor),
            sidebarContainer.bottomAnchor.constraint(equalTo: container.bottomAnchor),
            sidebarWidthConstraint,

            mainContentContainer.leadingAnchor.constraint(equalTo: sidebarContainer.trailingAnchor),
            mainContentContainer.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            mainContentContainer.topAnchor.constraint(equalTo: container.topAnchor),
            mainContentContainer.bottomAnchor.constraint(equalTo: container.bottomAnchor),
        ])

        sidebarContainer.setContentView(sidebarHostingView)
        mainContentContainer.setContentView(mainContentHostingView)

        self.view = container
    }

    override func viewDidAppear() {
        super.viewDidAppear()
        if let window = view.window {
            window.isMovableByWindowBackground = true
        }
    }
}
