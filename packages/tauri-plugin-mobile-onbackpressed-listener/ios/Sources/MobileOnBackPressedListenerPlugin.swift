import SwiftRs
import Tauri
import UIKit
import WebKit
import BackpressedKit

class MobileOnBackPressedListenerPlugin: Plugin, UIGestureRecognizerDelegate {
    var webView: WKWebView!
    override func load(webview: WKWebView) {
        webView = webview
        let rootView = webview.superview!
        let leftEdgeAnimationView = EdgeAnimationView(frame: CGRect(x: 0, y: 300, width: 0, height: 200), rectEdge: .left) {
            self.onBackPressed()
        }
        let rightEdgeAnimationView = EdgeAnimationView(frame: CGRect(x: rootView.bounds.width, y: 300, width: 0, height: 200), rectEdge: .right) {
            self.onBackPressed()
        }
        rootView.insertSubview(leftEdgeAnimationView, aboveSubview: webview)
        rootView.insertSubview(rightEdgeAnimationView, aboveSubview: webview)
        setupEdgePanGesture(target: leftEdgeAnimationView, edges: .left)
        setupEdgePanGesture(target: rightEdgeAnimationView, edges: .right)
    }

    @objc public func registerBackEvent(_ invoke: Invoke) throws {
        invoke.resolve()
    }

    private func onBackPressed() {
        let jsObject: JSObject = [:]
        trigger("mobile-onbackpressed-goback", data: jsObject)
    }

    private func setupEdgePanGesture(target: EdgeAnimationView, edges: UIRectEdge) {
        let edgePan = UIScreenEdgePanGestureRecognizer(target: target, action: #selector(target.handlePanGesture))
        edgePan.edges = edges
        edgePan.delegate = self
        webView.superview!.addGestureRecognizer(edgePan)
    }

    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        if gestureRecognizer is UIScreenEdgePanGestureRecognizer {
            return true
        }
        return false
    }

    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return gestureRecognizer is UIScreenEdgePanGestureRecognizer || otherGestureRecognizer is UIScreenEdgePanGestureRecognizer
    }
}

@_cdecl("init_plugin_mobile_onbackpressed_listener")
func initPlugin() -> Plugin {
    return MobileOnBackPressedListenerPlugin()
}
