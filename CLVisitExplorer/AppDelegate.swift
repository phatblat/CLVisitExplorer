//
//  AppDelegate.swift
//  CLVisitExplorer
//
//  Created by Ben Chatelain on 6/22/16.
//  Copyright © 2016 Ben Chatelain. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder {
    var window: UIWindow?
}

extension AppDelegate: UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {

        if let options = launchOptions where options[UIApplicationLaunchOptionsLocationKey] != nil {
            debugPrint("App was launched in response to an incoming location event")
        }
        LocationManager.shared.restartLocationServices()

        let settings = UIUserNotificationSettings(types: [.alert], categories: nil)
        application.registerUserNotificationSettings(settings)

        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {}

    func applicationDidEnterBackground(_ application: UIApplication) {}

    func applicationWillEnterForeground(_ application: UIApplication) {}

    func applicationDidBecomeActive(_ application: UIApplication) {}

    func applicationWillTerminate(_ application: UIApplication) {}

    func application(_ application: UIApplication, didReceive notification: UILocalNotification) {
        debugPrint("didReceive", notification)
    }

    func application(_ application: UIApplication, didRegister notificationSettings: UIUserNotificationSettings) {
        debugPrint("didRegister", notificationSettings)
    }
}

private extension AppDelegate {
    private var defaults: UserDefaults { return UserDefaults.standard() }
}
