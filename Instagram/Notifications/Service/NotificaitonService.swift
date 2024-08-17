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
        return DeveloperPreview.shared.notifications
    }
    
    func uploadNotification(toUid uid: String, type: NotificaitonType, post: Post? = nil) {
            guard let currentUid = Auth.auth().currentUser?.uid, uid != currentUid else {
                print("Cannot send notification: current user is nil or same as target user")
                return
            }
            let ref = FirebaseConstants.NotifcationCollection.document(uid).collection("user-notifications").document()
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
