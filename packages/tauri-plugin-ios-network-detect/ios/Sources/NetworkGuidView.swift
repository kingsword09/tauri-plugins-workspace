//
//  network.swift
//  tauri-plugin-ios-network-detect
//
//  Created by kingsword09 on 2025/2/20.
//

import SwiftUI

public struct NetworkGuidView: View {
    private var imageWidth: CGFloat { UIScreen.main.bounds.width - 30 }
    private var imageHeight: CGFloat { imageWidth * CGFloat(85.0 / 117) }

    public init() {}

    public var body: some View {
        ZStack(alignment: .top) {
            Color(UIColor.systemBackground)
            VStack {
                Spacer().frame(height: 10)

                RoundedRectangle(cornerRadius: 2.5)
                    .frame(width: 60, height: 6)
                    .foregroundColor(.secondary)
                Spacer().frame(height: 52)

                Image(uiImage: UIImage(systemName: "wifi.slash")!)
                    .resizable()
                    .frame(width: 40, height: 40)

                Spacer().frame(height: 32)

                Text("网络连接未成功，请点击“打开设置”进行设置")
                    .font(.system(size: 16).bold()).foregroundColor(Color(UIColor.label))

                Spacer().frame(height: 32)

                Button("打开设置") {
                    openSettings()
                }
            }
        }
    }

    private func openSettings() {
        guard let settingsURL = URL(string: UIApplication.openSettingsURLString) else { return }
        UIApplication.shared.open(settingsURL)
    }
}

struct NetworkGuidView_Previews: PreviewProvider {
    static var previews: some View {
        NetworkGuidView()
    }
}
