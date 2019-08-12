//
//  Log.swift
//  SterlingNetworking
//
//  Created by Olar's Mac on 8/8/19.
//  Copyright © 2019 Adie Olalekan. All rights reserved.
//

import Foundation

public enum LogType: String {
    case lin = "✏️"
    case error = "❗️"
    case date = "🕒"
    case url = "🌏"
    case json = "💡"
    case fuck = "🖕"
    case happy = "😄"
}

public func log<T>(_ message: T, _ type: LogType = .lin, file: String = #file, method: String = #function, line: Int = #line) {
    #if DEBUG
    print("\(type.rawValue) \((file as NSString).lastPathComponent)[\(line)], \(method): \(message)")
    #endif
}
