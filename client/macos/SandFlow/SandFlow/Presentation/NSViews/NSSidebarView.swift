//
//  SidebarView.swift
//  SandFlow
//
//  Created by 木本瑛介 on 2026/05/28.
//

import AppKit

final class NSSidebarView: NSView {

    static let standardWidth: CGFloat = 220
    static let maximumWidth: CGFloat = 420

    init() {
        super.init(frame: .zero)
        wantsLayer = true
        layer?.masksToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // The content view keeps a fixed width anchored to the leading edge instead of
    // tracking the container's trailing edge. 
    private(set) var contentWidthConstraint: NSLayoutConstraint?

    func setContentView(_ view: NSView, width: CGFloat) {
        subviews.forEach { $0.removeFromSuperview() }
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        let widthConstraint = view.widthAnchor.constraint(equalToConstant: width)
        contentWidthConstraint = widthConstraint
        NSLayoutConstraint.activate([
            view.leadingAnchor.constraint(equalTo: leadingAnchor),
            view.topAnchor.constraint(equalTo: topAnchor),
            view.bottomAnchor.constraint(equalTo: bottomAnchor),
            widthConstraint,
        ])
    }
}
