//
//  CreateTaskView.swift
//  SandFlow
//
//  Created by 木本瑛介 on 2026/05/30.
//

import SwiftUI

struct CreateTaskView: View {
    @State private var taskTitle: String = ""
    
    var body: some View {
        VStack(alignment: .leading, spacing: .zero) {
            headerView
                .padding(.top, 24)
        }
        .frame(maxHeight: .infinity, alignment: .top)
    }
    
    @ViewBuilder
    private var headerView: some View {
        VStack(spacing: 18) {
            HStack {
                Image(systemName: "pencil")
                    .font(.system(size: 30, weight: .medium))
                    .foregroundStyle(.black.opacity(0.5))
                TextField("タスクを入力", text: $taskTitle, axis: .vertical)
                    .textFieldStyle(.plain)
                    .font(.system(size: 30, weight: .medium))
                    .foregroundStyle(.black.opacity(0.5))
            }
            
            HStack {
                Image(systemName: "person.fill")
                    .font(.system(size: 18, weight: .medium))
                    .foregroundStyle(.black.opacity(0.5))
                Text("担当者")
                    .font(.system(size: 18, weight: .medium))
                    .foregroundStyle(.black.opacity(0.5))
                Spacer()
            }
            
            Rectangle()
                .frame(height: 0.5)
                .foregroundStyle(.white.opacity(0.5))
        }
        .padding(.horizontal, 24)
    }
}
