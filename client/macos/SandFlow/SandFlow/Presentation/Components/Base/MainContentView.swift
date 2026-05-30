//
//  MasterView.swift
//  SandFlow
//
//  Created by 木本瑛介 on 2026/05/28.
//

import Foundation
import SwiftUI

struct MainContentView: View {
    @Binding var isSidebarOpen: Bool
    @Binding var selectedSection: SidebarSection

    var body: some View {
        VStack(spacing: .zero) {
            headerView
            content
        }
        .frame(maxHeight: .infinity, alignment: .top)
    }

    @ViewBuilder
    private var content: some View {
        switch selectedSection {
        case .createTask:
            CreateTaskView()
        case .tasks:
            TasksView()
        }
    }

    @ViewBuilder
    private var headerView: some View {
        HStack {
            Button(action: { isSidebarOpen.toggle() }) {
                Image(systemName: "sidebar.left")
            }
            .buttonStyle(.plain)
            Spacer()
        }
        .padding(.horizontal, 10)
    }
}
