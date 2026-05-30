//
//  SidebarSection.swift
//  SandFlow
//
//  Created by 木本瑛介 on 2026/05/30.
//

import Foundation

enum SidebarSection: CaseIterable, Identifiable {
    case createTask
    case tasks

    var id: Self { self }
}
