//
//  RouteViewController.swift
//  SandFlow
//
//  Created by 木本瑛介 on 2026/05/30.
//

import AppKit
import SwiftUI

enum RouteChangeAnimationStyle {
    case horizontal
    case vertical
}

struct RouteViewController<Route: Equatable, Screen: View>: NSViewControllerRepresentable {
    
    let routeViewModel: RouteViewModel<Route>
    let animated: Bool
    let animationStyle: RouteChangeAnimationStyle
    
    @ViewBuilder
    let builder: (Route) -> Screen
    
    init(routeViewModel: RouteViewModel<Route>,
         animated: Bool = true,
         animationStyle: RouteChangeAnimationStyle,
         @ViewBuilder builder: @escaping (Route) -> Screen) {
        self.routeViewModel = routeViewModel
        self.animated = animated
        self.animationStyle = animationStyle
        self.builder = builder
    }
    
    func makeNSViewController(context: Context) -> NavigationStackController {
        let navigation = NavigationStackController()
        navigation.animationStyle = animationStyle
        
        let routes = routeViewModel.routes.map{ NSHostingController(rootView: builder($0)) }
        navigation.setRoutes(routes)
        
        routeViewModel.onPush = { route in
            navigation.push(NSHostingController(rootView: builder(route)), animated: true)
        }
        
        routeViewModel.onPop = { count in
            navigation.pop(count, animated: true)
        }
        
        return navigation
    }
    
    func updateNSViewController(_ nsViewController: NavigationStackController, context: Context) {}
}

final class NavigationStackController: NSViewController {
    private enum Operation {
        case push
        case pop
    }
    
    private static let transitionDuration: TimeInterval = 0.3
    var animationStyle: RouteChangeAnimationStyle = .horizontal
    
    private(set) var stack: [NSViewController] = []
    
    override func loadView() {
        let container = NSView()
        container.translatesAutoresizingMaskIntoConstraints = false
        view = container
    }
    
    public func setRoutes(_ controllers: [NSViewController]) {
        stack.forEach {
            $0.view.removeFromSuperview()
            $0.removeFromParent()
        }
        stack = []
        
        controllers.forEach { addChild($0) }
        stack = controllers
        
        if let top = controllers.last {
            embed(top.view)
        }
    }
    
    public func push(_ controller: NSViewController, animated: Bool) {
        addChild(controller)
        let from = stack.last
        stack.append(controller)
        
        guard let from, animated else {
            from?.view.removeFromSuperview()
            embed(controller.view)
            return
        }

        controller.view.frame = view.bounds
        controller.view.autoresizingMask = [.width, .height]
        transition(from: from, to: controller, options: options(for: .push)) {
            from.view.removeFromSuperview()
        }
    }
    
    public func pop(_ count: Int, animated: Bool) {
        guard stack.count > 1, count > 0 else { return }
        
        let removeCount = min(count, stack.count - 1)
        let targetIndex = stack.count - 1 - removeCount
        let from = stack[stack.count - 1]
        let to = stack[targetIndex]
        let removed = Array(stack[(targetIndex + 1)...])
        
        func cleanup() {
            from.view.removeFromSuperview()
            removed.forEach { $0.removeFromParent() }
            stack.removeLast(removeCount)
        }
        
        guard animated else {
            embed(to.view)
            cleanup()
            return
        }
        
        to.view.frame = view.bounds
        to.view.autoresizingMask = [.width, .height]
        transition(from: from, to: to, options: options(for: .pop)) {
            cleanup()
        }
    }
    
    private func embed(_ subView: NSView) {
        subView.frame = view.bounds
        subView.autoresizingMask = [.width, .height]
        view.addSubview(subView)
    }
    
    private func options(for operation: Operation) -> NSViewController.TransitionOptions {
        let base: NSViewController.TransitionOptions = [.allowUserInteraction]
        switch (animationStyle, operation) {
        case (.horizontal, .push): return base.union(.slideForward)
        case (.horizontal, .pop): return base.union(.slideBackward)
        case (.vertical, .push): return base.union(.slideDown)
        case (.vertical, .pop): return base.union(.slideUp)
        }
    }
}
