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
    
    func sendNotification(at date: Date) {
        print("ПОПАЛИ СЮДА")
        let content = UNMutableNotificationContent()
        content.title = "Напоминание"
        content.body = "Пора смотреть фильмы!"
        content.sound = .default
        
        let calendar = Calendar.current
        let dateComponents = calendar.dateComponents([.hour, .minute], from: date)
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Error notif")
            }
        }
     }
}
