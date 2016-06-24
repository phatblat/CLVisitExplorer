//
//  Defaults.swift
//  CLVisitExplorer
//
//  Created by Ben Chatelain on 6/22/16.
//  Copyright © 2016 Ben Chatelain. All rights reserved.
//

/// Keys used for storing values in UserDefaults.
///
/// - monitoringLocation: Boolean indicating whether location monitoring is active.
/// - monitoringVisits:   Boolean indicating whether visit monitoring is active.
enum Defaults: String {
    /// Boolean indicating whether location monitoring is active.
    case monitoringLocation

    /// Boolean indicating whether visit monitoring is active.
    case monitoringVisits
}

import Foundation

/// Adds methods working with Default enum values for keys instead of strings.
extension UserDefaults {
    /// Convenience property for standard UserDefaults.
    private var defaults: UserDefaults { return UserDefaults.standard() }

    /// Overload taking a `Defaults` value for the key.
    ///
    /// - parameter defaultKey: `Defaults` enum value
    ///
    /// - returns: true or false
    func bool(forKey defaultKey: Defaults) -> Bool {
        return defaults.bool(forKey: defaultKey.rawValue)
    }

    /// Experimental generic form for the various value retrieval methods. Infers type based on return context.
    ///
    /// - parameter defaultKey: `Defaults` enum value
    ///
    /// - returns: Value found in UserDefaults cast to the type requested.
    ///
    /// - note: Currently only `Bool` is supported
    ///
    /// - warning: Unsupported types cause a runtime crash.
    func value<T: CustomReflectable>(forKey defaultKey: Defaults) -> T {
        switch T.self {
        case is Bool.Type:
            return defaults.bool(forKey: defaultKey) as! T
        default:
            fatalError("Unsupported return type")
        }
    }
}
