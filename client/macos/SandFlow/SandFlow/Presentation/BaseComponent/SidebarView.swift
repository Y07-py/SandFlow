//
//  SideBarView.swift
//  SandFlow
//
//  Created by 木本瑛介 on 2026/05/28.
//

import Foundation
import SwiftUI

struct SidebarView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("Sidebar")
                .foregroundStyle(.secondary)
                .font(.system(size: 13, weight: .medium))
            Spacer()
        }
        .padding(.top, 40)
        .padding(.horizontal, 16)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
    }
}
