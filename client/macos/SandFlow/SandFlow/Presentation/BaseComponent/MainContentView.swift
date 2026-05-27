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

    var body: some View {
        VStack {
            headerView
        }
        .frame(maxHeight: .infinity, alignment: .top)
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
