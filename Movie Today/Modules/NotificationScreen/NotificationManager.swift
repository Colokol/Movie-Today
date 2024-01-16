//
//  NotificationManager.swift
//  Movie Today
//
//  Created by Nikita on 13.01.2024.
//

import Foundation
import UserNotifications

class NotificationManager {
    
    //MARK: - Properties
    
    let notificationCenter = UNUserNotificationCenter.current()
    
    //MARK: - Methods
    
    func checkAuthorization() {
        notificationCenter.requestAuthorization(options: [.alert, .sound, .badge]) { (granted, error) in
            guard granted else { return }
            self.notificationCenter.getNotificationSettings { setting in
                guard setting.authorizationStatus == .authorized else { return }
            }
        }
    }
    
    func sendNotification(after seconds: Int) {
        let identifier = "notif"
        let notifTitle = "Все фильмы тут!"
        let notifBody = "Выберите что посмотреть этим вечером"
        
        let content = UNMutableNotificationContent()
        content.title = notifTitle
        content.body = notifBody
        content.sound = .default
        
        let notifTrigger = UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval(seconds), repeats: true)
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: notifTrigger)
        notificationCenter.add(request)
    }
}
