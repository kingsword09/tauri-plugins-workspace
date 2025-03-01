//
//  NetworkPermission.swift
//  tauri-plugin-ios-network-detect
//
//  Created by kingsword09 on 2025/2/20.
//

import Network
import Foundation

public class NetworkManager: NSObject {
    @objc public dynamic var isNetworkAvailable = true
    private let monitor = NWPathMonitor()
    private let queue = DispatchQueue(label: "NetworkMonitor")

    public override init() {
        super.init()
        checkNetworkPermission()
    }
    
    public func checkNetworkPermission() {
        monitor.start(queue: queue)
        monitor.pathUpdateHandler = { [weak self] path in
            DispatchQueue.main.async {
                self?.isNetworkAvailable = path.status == .satisfied
            }
        }
    }
    deinit {
        monitor.cancel()
    }
}
