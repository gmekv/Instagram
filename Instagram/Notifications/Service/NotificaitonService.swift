//
//  NotificaitonService.swift
//  Instagram
//
//  Created by Giorgi Mekvabishvili on 17.08.24.
//

import Firebase
import FirebaseAuth

class NotificaitonService {
    func fetchNotifications() async throws -> [Notification] {
        guard let currentUid = Auth.auth().currentUser?.uid else { return [] }
        let snapshot = try await FirebaseConstants.UserNotificationCollection(uid: currentUid).getDocuments()
        
        let notifications = snapshot.documents.compactMap { try? $0.data(as: Notification.self) }

        // Print each notification
        notifications.forEach { notification in
            print("Fetched Notification: \(notification)")
        }
        
        return notifications
    }
    
    func uploadNotification(toUid uid: String, type: NotificaitonType, post: Post? = nil) {
            guard let currentUid = Auth.auth().currentUser?.uid, uid != currentUid else {return}
            let ref = FirebaseConstants.UserNotificationCollection(uid: uid).document()
            let notification = Notification(id: ref.documentID, postID: post?.id, timestamp: Timestamp(), notificationSenderUid: currentUid, type: type)
            guard let notifiationData = try? Firestore.Encoder().encode(notification) else {
                print("Failed to encode notification data")
                return
            }
            ref.setData(notifiationData) { error in
                if let error = error {
                    print("Error uploading notification: \(error.localizedDescription)")
                } else {
                    print("Notification successfully uploaded for user: \(uid)")
                }
            }
        }

    func deleteNotification(toUid uid: String, type: NotificaitonType, post: Post? = nil) {
        
    }
}
