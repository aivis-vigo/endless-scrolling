//
//  NetworkMonitor.swift
//  endless-scrolling
//
//  Created by Aivis Vigo Reimarts on 12/01/2026.
//

import Combine
import Network

@MainActor
class NetworkMonitor: ObservableObject {
    @Published private(set) var path: NWPath?
    @Published var isConnected: Bool = false

    private var monitor: NWPathMonitor?

    init() {
        monitor = NWPathMonitor()
        startMonitoring()
    }

    deinit {
        monitor?.cancel()
        monitor = nil
    }

    private func startMonitoring() {
        monitor = NWPathMonitor()

        monitor?.pathUpdateHandler = { [weak self] path in
            Task { @MainActor [weak self] in
                self?.path = path
                self?.isConnected = path.status == .satisfied
            }
        }

        monitor?.start(queue: .global(qos: .background))
    }

}
