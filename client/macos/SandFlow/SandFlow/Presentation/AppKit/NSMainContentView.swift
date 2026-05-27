//
//  MainContentView.swift
//  SandFlow
//
//  Created by 木本瑛介 on 2026/05/28.
//

import AppKit

final class NSMainContentView: NSView {

    private let contentBackground = NSView()

    init() {
        super.init(frame: .zero)
        wantsLayer = true
        translatesAutoresizingMaskIntoConstraints = false
        setupBackground()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setContentView(_ view: NSView) {
        contentBackground.subviews.forEach { $0.removeFromSuperview() }
        view.translatesAutoresizingMaskIntoConstraints = false
        contentBackground.addSubview(view)
        NSLayoutConstraint.activate([
            view.leadingAnchor.constraint(equalTo: contentBackground.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: contentBackground.trailingAnchor),
            view.topAnchor.constraint(equalTo: contentBackground.topAnchor),
            view.bottomAnchor.constraint(equalTo: contentBackground.bottomAnchor),
        ])
    }

    private func setupBackground() {
        contentBackground.wantsLayer = true
        contentBackground.translatesAutoresizingMaskIntoConstraints = false
        contentBackground.layer?.backgroundColor = NSColor.underPageBackgroundColor.cgColor
        contentBackground.layer?.cornerRadius = 12
        contentBackground.layer?.masksToBounds = true
        addSubview(contentBackground)

        NSLayoutConstraint.activate([
            contentBackground.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentBackground.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            contentBackground.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            contentBackground.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
        ])
    }

    override func updateLayer() {
        super.updateLayer()
        contentBackground.layer?.backgroundColor = NSColor.underPageBackgroundColor.cgColor
    }
}
