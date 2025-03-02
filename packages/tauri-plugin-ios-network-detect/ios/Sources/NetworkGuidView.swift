//
//  network.swift
//  tauri-plugin-ios-network-detect
//
//  Created by kingsword09 on 2025/2/20.
//

import SwiftUI

public struct NetworkGuidView: View {
    @State private var isAnimating = false
    
    public init() {}
    
    public var body: some View {
        ZStack(alignment: .top) {
            Color(UIColor.systemBackground)
            
            VStack(spacing: 0) {
                // 顶部把手
                RoundedRectangle(cornerRadius: 2.5)
                    .frame(width: 40, height: 5)
                    .foregroundColor(Color(.systemGray4))
                    .padding(.top, 8)
                
                ScrollView {
                    VStack(spacing: 24) {
                        // 头部图标
                        Circle()
                            .fill(Color(.systemGray6))
                            .frame(width: 80, height: 80)
                            .overlay(
                                Image(systemName: "wifi.slash")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 40, height: 40)
                                    .foregroundColor(.red)
                                    .rotationEffect(.degrees(isAnimating ? 10 : -10))
                                    .animation(Animation.easeInOut(duration: 1).repeatForever(autoreverses: true), value: isAnimating)
                            )
                            .padding(.top, 32)
                        
                        // 主标题
                        Text("网络访问受限")
                            .font(.system(size: 22, weight: .bold))
                            .foregroundColor(Color(.label))
                        
                        // 说明文本
                        Text("应用需要访问网络以提供完整功能。\n请按照以下步骤开启网络权限：")
                            .font(.system(size: 16))
                            .foregroundColor(Color(.secondaryLabel))
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 24)
                        
                        // 步骤指引
                        VStack(alignment: .leading, spacing: 16) {
                            StepView(number: "1", text: "点击下方“打开设置”按钮")
                            StepView(number: "2", text: "找到“网络”选项")
                            StepView(number: "3", text: "开启“无线数据”或“WLAN”")
                        }
                        .padding(.horizontal, 32)
                        .padding(.vertical, 16)
                        
                        Spacer()
                        
                        // 操作按钮
                        Button(action: openSettings) {
                            Text("打开设置")
                                .font(.system(size: 17, weight: .semibold))
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .frame(height: 50)
                                .background(Color.blue)
                                .cornerRadius(12)
                        }
                        .padding(.horizontal, 24)
                        .padding(.bottom, 32)
                    }
                }
            }
        }
        .onAppear {
            isAnimating = true
        }
    }
    
    private func openSettings() {
        guard let settingsURL = URL(string: UIApplication.openSettingsURLString) else { return }
        UIApplication.shared.open(settingsURL)
    }
}

// 步骤视图组件
struct StepView: View {
    let number: String
    let text: String
    
    var body: some View {
        HStack(spacing: 16) {
            ZStack {
                Circle()
                    .fill(Color.blue.opacity(0.1))
                    .frame(width: 32, height: 32)
                Text(number)
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.blue)
            }
            Text(text)
                .font(.system(size: 16))
                .foregroundColor(Color(.label))
        }
    }
}

struct NetworkGuidView_Previews: PreviewProvider {
    static var previews: some View {
        NetworkGuidView()
    }
}
