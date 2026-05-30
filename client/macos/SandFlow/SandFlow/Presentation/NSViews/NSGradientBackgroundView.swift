//
//  NSGradientBackgroundView.swift
//  SandFlow
//
//  Created by 木本瑛介 on 2026/05/30.
//

import AppKit

/// A soft mint-green to cyan vertical gradient used as the window background
/// behind the (transparent) sidebar.
final class NSGradientBackgroundView: NSView {

    private let gradientLayer = CAGradientLayer()

    init() {
        super.init(frame: .zero)
        wantsLayer = true
        translatesAutoresizingMaskIntoConstraints = false
        setupGradient()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupGradient() {
        gradientLayer.colors = [
            NSColor(srgbRed: 0.776, green: 0.906, blue: 0.812, alpha: 1).cgColor, // mint green
            NSColor(srgbRed: 0.761, green: 0.894, blue: 0.851, alpha: 1).cgColor, // teal-mint
            NSColor(srgbRed: 0.749, green: 0.886, blue: 0.927, alpha: 1).cgColor, // cyan
        ]
        // macOS layer coordinates: y = 1 is the top edge, y = 0 is the bottom edge.
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 1) // top -> mint
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 0)   // bottom -> cyan
        layer?.addSublayer(gradientLayer)
    }

    override func layout() {
        super.layout()
        gradientLayer.frame = bounds
    }
}
