//
//  AppComponent.swift
//  Notification Agent
//
//  Created by Simone Martorelli on 25/06/2021.
//  Copyright © 2021 IBM Inc. All rights reserved.
//  SPDX-License-Identifier: Apache2.0
//

import Foundation

/// This represents all the available components for the agent.
enum AppComponent {
    case popup
    case banner
    case alert
    case onboarding
    case core
    var bundleName: String {
        switch self {
        case .core:
            return "Pixel Machinery"
        case .alert:
            return "Pixel Machinery Alert"
        case .banner:
            return "Pixel Machinery Banner"
        case .onboarding:
            return "Pixel Machinery Onboarding"
        case .popup:
            return "Pixel Machinery Popup"
        }
    }
    var binaryPath: String {
        return "/Contents/MacOS/\(self.bundleName)"
    }
    var componentDirectory: String {
        switch self {
        case .core:
            return ""
        case .popup, .banner, .alert, .onboarding:
            return "/Contents/Helpers/"
        }
    }
    private var current: AppComponent {
        switch Bundle.main.bundleIdentifier! {
        case "com.ibm.cio.notifier":
            return .core
        case "com.ibm.cio.notifier.alert":
            return .alert
        case "com.ibm.cio.notifier.banner":
            return .banner
        case "com.ibm.cio.notifier.popup":
            return .popup
        case "com.ibm.cio.notifier.onboarding":
            return .onboarding
        default:
            return .core
        }
    }
    /// The local relative path for the component.
    func getRelativeComponentPath() -> String {
        guard current != .core else {
            return Bundle.main.bundlePath + self.componentDirectory + self.bundleName + ".app" + self.binaryPath
        }
        return Bundle.main.bundlePath.replacingOccurrences(of: "\(current.bundleName)", with: "\(self.bundleName)") + self.binaryPath
    }
}
