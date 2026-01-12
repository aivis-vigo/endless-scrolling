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

    // used to prevent memory leaks when object is destoryed
    deinit {
        monitor?.cancel()
        monitor = nil
    }

    private func startMonitoring() {
        monitor = NWPathMonitor()

        /*
             @MainActor is used to run this part on the main thread because it affects UI changes
        
             Status codes:
                .satisfied = connected to internet
                .unsatisfied = no internet connection
                .requiresConnection = connection not yet established
         */
        monitor?.pathUpdateHandler = { [weak self] path in
            Task { @MainActor [weak self] in
                self?.path = path
                self?.isConnected = path.status == .satisfied
            }
        }

        // Start monitoring on a background thread, helping main thread to run more smoothly for the UI changes
        monitor?.start(queue: .global(qos: .background))
    }

}
