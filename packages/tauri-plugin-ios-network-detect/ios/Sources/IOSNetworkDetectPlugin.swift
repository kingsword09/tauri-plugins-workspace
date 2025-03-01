import SwiftRs
import SwiftUI
import Tauri
import UIKit
import WebKit

class PingArgs: Decodable {
    let value: String?
}

class IOSNetworkDetectPlugin: Plugin {
    var webView: WKWebView!

    // 模拟 NetworkManager
    private var networkManager: NetworkManager?

    // 观察网络状态变化
    private var isNetworkAvailableObserver: NSKeyValueObservation?
    private var networkGuidView = NetworkGuidView()

    override public func load(webview: WKWebView) {
        webView = webview

        // 监听 networkManager.isNetworkAvailable 的变化
        let networkManager = NetworkManager()
        self.networkManager = networkManager
        isNetworkAvailableObserver = networkManager.observe(\.isNetworkAvailable) { [weak self] manager, _  in
            guard let self = self else { return }

            let controller = UIHostingController(rootView: networkGuidView)
            controller.modalPresentationStyle = .pageSheet
            
            let keyWindow = if #available(iOS 15.0, *) {
                UIApplication.shared.connectedScenes.compactMap({ ($0 as? UIWindowScene)?.keyWindow }).last
            } else {
                UIApplication.shared.windows.first(where: { $0.isKeyWindow })
            }
            
            if let keyWindow = keyWindow {
                let rootViewController = keyWindow.rootViewController
                if !manager.isNetworkAvailable {
                    rootViewController?.present(controller, animated: true, completion: nil)
                } else {
                    if rootViewController?.presentedViewController != nil {
                        rootViewController?.dismiss(animated: true) {
                            self.networkManager = nil
                            self.isNetworkAvailableObserver = nil
                            self.webView.reload()
                        }
                    }
                }
            }
        }
    }
}

@_cdecl("init_plugin_ios_network_detect")
func initPlugin() -> Plugin {
    return IOSNetworkDetectPlugin()
}
