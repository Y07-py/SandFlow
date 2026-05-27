//
//  SidebarView.swift
//  SandFlow
//
//  Created by 木本瑛介 on 2026/05/28.
//

import AppKit

final class NSSidebarView: NSView {

    static let standardWidth: CGFloat = 220

    init() {
        super.init(frame: .zero)
        wantsLayer = true
        layer?.masksToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setContentView(_ view: NSView) {
        subviews.forEach { $0.removeFromSuperview() }
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        NSLayoutConstraint.activate([
            view.leadingAnchor.constraint(equalTo: leadingAnchor),
            view.widthAnchor.constraint(equalToConstant: Self.standardWidth),
            view.topAnchor.constraint(equalTo: topAnchor),
            view.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
}
