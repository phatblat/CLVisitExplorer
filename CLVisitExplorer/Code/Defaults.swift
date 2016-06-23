//
//  Defaults.swift
//  CLVisitExplorer
//
//  Created by Ben Chatelain on 6/22/16.
//  Copyright © 2016 Ben Chatelain. All rights reserved.
//

/// Keys used for storing values in UserDefaults.
enum Defaults: String {
    /// Boolean flag indicating whether location monitoring is active.
    case monitoringLocation

    /// Boolean flag indicating whether visit monitoring is active.
    case monitoringVisits
}

import Foundation

/// Adds methods working with Default enum values for keys instead of strings.
extension UserDefaults {
    /// Convenience property for standard UserDefaults.
    private var defaults: UserDefaults { return UserDefaults.standard() }

    func bool(forKey defaultKey: Defaults) -> Bool {
        return defaults.bool(forKey: defaultKey.rawValue)
    }

    func value<T: CustomReflectable>(forKey defaultKey: Defaults) -> T {
        switch T.self {
        case is Bool.Type:
            return defaults.bool(forKey: defaultKey) as! T
        default:
            fatalError("Unsupported return type")
        }
    }
}
