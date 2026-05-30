//
//  RouteViewModel.swift
//  SandFlow
//
//  Created by 木本瑛介 on 2026/05/31.
//

import Foundation
import SwiftUI
import Combine

final class RouteViewModel<Route: Equatable>: ObservableObject {
    public var routes: [Route] = []
    
    var onPush: ((Route) -> Void)?
    var onPop: ((Int) -> Void)?
    
    init(route: Route) {
        self.routes.append(route)
    }
    
    public func onPush(_ route: Route) {
        onPush?(route)
    }
    
    public func onPop(_ cnt: Int) {
        onPop?(cnt)
    }
}
