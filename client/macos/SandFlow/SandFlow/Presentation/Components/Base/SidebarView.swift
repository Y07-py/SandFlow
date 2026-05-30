//
//  SideBarView.swift
//  SandFlow
//
//  Created by 木本瑛介 on 2026/05/28.
//

import Foundation
import SwiftUI

struct SidebarView: View {
    @Binding var isSidebarOpen: Bool
    @Binding var selectedSection: SidebarSection

    @Environment(\.colorScheme) private var colorScheme

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            // Create Task
            Button(action: { selectedSection = .createTask }) {
                HStack {
                    Image(systemName: "plus")
                        .font(.system(size: 12, weight: .bold))
                        .foregroundStyle(tint(for: .createTask))
                    Text("Create Task")
                        .font(.system(size: 12, weight: .bold))
                        .foregroundStyle(tint(for: .createTask))
                }
                .padding(.horizontal, 12)
                .padding(.vertical, 6)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(rowBackground(for: .createTask))
                .contentShape(Rectangle())
            }
            .buttonStyle(.plain)
            .padding(.horizontal, 8)
            .padding(.top, 22)

            // Tasks
            Button(action: { selectedSection = .tasks }) {
                HStack {
                    Image("folder-icon")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 22, height: 22)
                        .foregroundStyle(tint(for: .tasks))
                    Text("Tasks")
                        .font(.system(size: 12, weight: .bold))
                        .foregroundStyle(tint(for: .tasks))
                }
                .padding(.horizontal, 12)
                .padding(.vertical, 6)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(rowBackground(for: .tasks))
                .contentShape(Rectangle())
            }
            .buttonStyle(.plain)
            .padding(.horizontal, 8)
            .padding(.top, 10)
        }
        .frame(maxHeight: .infinity, alignment: .top)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
    }

    private func tint(for section: SidebarSection) -> Color {
        selectedSection == section ? .black : .black.opacity(0.5)
    }

    private func rowBackground(for section: SidebarSection) -> some View {
        RoundedRectangle(cornerRadius: 8, style: .continuous)
            .fill(selectedSection == section ? selectionColor : Color.clear)
    }

    private var selectionColor: Color {
        colorScheme == .dark ? Color.white.opacity(0.16) : Color.black.opacity(0.10)
    }
}
