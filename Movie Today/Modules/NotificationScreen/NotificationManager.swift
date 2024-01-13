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
    
    func sendNotification() {
        let identifier = "notif"
        let notifTitle = "Все фильмы тут!"
        let notifBody = "Выберите что посмотреть этим вечером"
        let hour = 22
        let minute = 34
        let isDaily = true
        
        let content = UNMutableNotificationContent()
        content.title = notifTitle
        content.body = notifBody
        content.sound = .default
        
        let calendar = Calendar.current
        var dateComponents = DateComponents(calendar: calendar, timeZone: TimeZone.current)
        dateComponents.hour = hour
        dateComponents.minute = minute
        
        let notifTrigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: isDaily)
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: notifTrigger)
        notificationCenter.add(request)
    }
}
