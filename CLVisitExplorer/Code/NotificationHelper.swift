//
//  NotificationHelper.swift
//  CLVisitExplorer
//
//  Created by Ben Chatelain on 6/26/16.
//  Copyright © 2016 Ben Chatelain. All rights reserved.
//

import UIKit
import UserNotifications

class NotificationHelper {
    class func notify(_ visit: Visit) {
//        if #available(iOS 10.0, *) {
//            let notification = UNCalendarNotificationTrigger(dateMatching: <#T##DateComponents#>, repeats: <#T##Bool#>)
//        } else {
        let notification = UILocalNotification()
        notification.alertTitle = "Visit"
        notification.alertBody = String(visit)
        notification.soundName = UILocalNotificationDefaultSoundName
        UIApplication.shared().presentLocalNotificationNow(notification)
//        }
    }
}
