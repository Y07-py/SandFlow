//
//  SidbarResizeHandle.swift
//  SandFlow
//
//  Created by 木本瑛介 on 2026/05/30.
//

import AppKit

final class NSSidebarResizeHandleView: NSView {
    var onDrag: ((_ deltaX: CGFloat) -> Void)?
    private var lastX: CGFloat = 0
    
    override var mouseDownCanMoveWindow: Bool { false }
    
    override func resetCursorRects() {
        addCursorRect(bounds, cursor: NSCursor.columnResize(directions: .all))
    }
    
    override func mouseDown(with event: NSEvent) {
        lastX = event.locationInWindow.x
    }
    
    override func mouseDragged(with event: NSEvent) {
        let x = event.locationInWindow.x
        onDrag?(x - lastX)
        lastX = x
    }
}
