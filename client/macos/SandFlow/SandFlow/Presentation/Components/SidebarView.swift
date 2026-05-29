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
    
    @State private var selectedSection: Int? = nil
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            // Create Task
            Button(action: {}) {
                HStack {
                    Image(systemName: "plus")
                        .font(.system(size: 12, weight: .bold))
                        .foregroundStyle(.white)
                    Text("Create Task")
                        .font(.system(size: 12, weight: .bold))
                        .foregroundStyle(.white)
                }
                .padding(.horizontal, 16)
                .padding(.top, 28)
            }
            .buttonStyle(.plain)
            
            // Tasks
            Button(action: {}) {
                HStack {
                    Image("folder-icon")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 22, height: 22)
                        .foregroundStyle(.white)
                    Text("Tasks")
                        .font(.system(size: 12, weight: .bold))
                        .foregroundStyle(.white)
                }
                .padding(.horizontal, 16)
                .padding(.top, 18)
            }
            .buttonStyle(.plain)
        }
        .frame(maxHeight: .infinity, alignment: .top)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
    }
}
