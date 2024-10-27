//
//  Logger.swift
//  BridgetechAppsBanner
//
//  Created by Mark Bridges on 27/10/2024.
//

import Foundation
import OSLog

extension Logger {

    private static let subsystem = Bundle.main.bundleIdentifier ?? "com.bridgetech.appsbanner"
    
    static let standard = Logger(subsystem: subsystem, category: "standard")
}
