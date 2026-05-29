//
//  RootContainerViewController.swift
//  SandFlow
//
//  Created by 木本瑛介 on 2026/05/28.
//

import AppKit
import SwiftUI

final class RootContainerViewController: NSViewController {

    private static let backgroundColor: NSColor = .clear
    private static let sidebarOpenWidth: CGFloat = NSSidebarView.standardWidth
    private static let sidebarClosedWidth: CGFloat = 0
    private static let mainContentEdgeInset: CGFloat = 6
    private static let sidebarAnimationDuration: CFTimeInterval = 0.25
    
    private static let sidebarMinimumWidth: CGFloat = NSSidebarView.standardWidth
    private static let sidebarMaximumWidth: CGFloat = NSSidebarView.maximumWidth
    
    private let resizeHandle = NSSidebarResizeHandleView()
    private var currentSidebarWidth: CGFloat = NSSidebarView.standardWidth

    private static let trafficLightLeadingInset: CGFloat = 20
    private static let trafficLightTopInset: CGFloat = 22
    private static let trafficLightSpacing: CGFloat = 22

    private let sidebarContainer = NSSidebarView()
    private let mainContentContainer = NSMainContentView()
    private var sidebarWidthConstraint: NSLayoutConstraint!
    private var isSidebarAnimating = false

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
        let container = NSVisualEffectView()
        container.material = .underWindowBackground
        container.blendingMode = .behindWindow
        container.state = .active

        container.addSubview(sidebarContainer)
        container.addSubview(mainContentContainer)
        
        resizeHandle.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(resizeHandle)

        sidebarWidthConstraint = sidebarContainer.widthAnchor.constraint(
            equalToConstant: Self.sidebarOpenWidth
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
            
            resizeHandle.trailingAnchor.constraint(equalTo: sidebarContainer.trailingAnchor),
            resizeHandle.topAnchor.constraint(equalTo: sidebarContainer.topAnchor),
            resizeHandle.bottomAnchor.constraint(equalTo: sidebarContainer.bottomAnchor),
            resizeHandle.widthAnchor.constraint(equalToConstant: 6),
        ])

        sidebarContainer.setContentView(sidebarHostingView, width: Self.sidebarOpenWidth)
        mainContentContainer.setContentView(mainContentHostingView)

        resizeHandle.onDrag = { [weak self] dx in
            guard let self else { return }
            let proposedX = self.sidebarWidthConstraint.constant + dx
            let clampedX = min(max(proposedX, Self.sidebarMinimumWidth), Self.sidebarMaximumWidth)
            self.sidebarWidthConstraint.constant = clampedX
            self.sidebarContainer.contentWidthConstraint?.constant = clampedX
            self.currentSidebarWidth = clampedX
            self.repositionTrafficLights(animated: false)
        }

        self.view = container
    }

    override func viewDidAppear() {
        super.viewDidAppear()
        if let window = view.window {
            window.isMovableByWindowBackground = true
            window.isOpaque = false
            window.backgroundColor = .clear
        }
    }

    override func viewDidLayout() {
        super.viewDidLayout()
        guard !isSidebarAnimating else { return }
        repositionTrafficLights(animated: false)
    }
    
    // When the app is launched for the first time, closing the sidebar does not immediately update the `sidebarWidth.constant` property.
    // Therefore, we have added a `sidebarWidth` argument, if one is provided, I use it to compute the `sideOffset`.
    private func repositionTrafficLights(animated: Bool, sidebarWidth: CGFloat? = nil) {
        guard let window = view.window else { return }
        let buttonOrder: [NSWindow.ButtonType] = [.closeButton, .miniaturizeButton, .zoomButton]
        let effectiveWidth = sidebarWidth ?? sidebarWidthConstraint.constant
        let slideOffset = min(0, effectiveWidth - Self.sidebarMinimumWidth)
        for (index, type) in buttonOrder.enumerated() {
            guard let button = window.standardWindowButton(type),
                  let titlebar = button.superview,
                  titlebar.bounds.height > 0 else { continue }
            
            let x = Self.trafficLightLeadingInset + slideOffset + CGFloat(index) * Self.trafficLightSpacing
            let y = titlebar.bounds.height - button.frame.height - Self.trafficLightTopInset
            let target = NSPoint(x: x, y: y)
            
            if animated {
                button.animator().setFrameOrigin(target)
            } else {
                button.setFrameOrigin(target)
            }
        }
    }

    func setSidebarOpen(_ isOpen: Bool) {
        let widthTarget = isOpen ? currentSidebarWidth : Self.sidebarClosedWidth
        let mainLeadingTarget: CGFloat = isOpen ? 0 : Self.mainContentEdgeInset
        guard sidebarWidthConstraint.constant != widthTarget else { return }

        guard view.window != nil else {
            sidebarWidthConstraint.constant = widthTarget
            mainContentContainer.contentLeadingInset = mainLeadingTarget
            repositionTrafficLights(animated: false, sidebarWidth: widthTarget)
            return
        }

        isSidebarAnimating = true
        NSAnimationContext.runAnimationGroup({ context in
            context.duration = Self.sidebarAnimationDuration
            context.allowsImplicitAnimation = true
            context.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
            
            sidebarWidthConstraint.animator().constant = widthTarget
            mainContentContainer.contentLeadingInset = mainLeadingTarget
            repositionTrafficLights(animated: true, sidebarWidth: widthTarget)
            
            view.layoutSubtreeIfNeeded()
        }, completionHandler: { [weak self] in
            self?.isSidebarAnimating = false
        })
    }
}
