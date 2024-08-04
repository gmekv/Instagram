
import Firebase
import Foundation


class UserService {
    
    @Published var currentUser: User?
    
    static let shared = UserService()
    @MainActor
    func fetchCurrentUser() async throws {
        guard let uid = Auth.auth().currentUser?.uid else {return}
        self.currentUser = try await
        FirebaseConstants.UserCollection.document(uid).getDocument(as: User.self)
    }
    
    static func fetchAllUsers() async throws -> [User] {
        let snapshot = try await FirebaseConstants.UserCollection.getDocuments()
        let documents = snapshot.documents
        print("user fetched")
        return documents.compactMap({ try? $0.data(as: User.self) })
    }
    
    static func fetchUser(withUid uid: String) async throws -> User {
        let snapshot = try await FirebaseConstants.UserCollection.document(uid).getDocument()
        return try snapshot.data(as: User.self)
    }
}

extension UserService {
    static func follow(uid: String) async throws {
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        
        async let _ = try await FirebaseConstants.FollowingCOlelction.document(currentUid).collection("user-following").document(uid).setData([:])
        
    }
    
    static func unfollow(uid: String) async throws {
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        async let _ = try await FirebaseConstants.FollowingCOlelction.document(currentUid).collection("user-following").document(uid).delete()
    }
    
    static func checkIFuserisFollowed(uid: String ) async throws -> Bool {
        guard let currentUid = Auth.auth().currentUser?.uid else { return false}
        let snapshot = try await FirebaseConstants.FollowingCOlelction.document(currentUid).collection("user-following").document(uid).getDocument()
        return snapshot.exists
    }
}


extension UserService {
    
}

// Mark: - User Stats

extension UserService {
    static func fetchUserStats(uid: String) async throws -> UserStats {
        async let followingSnapshot = try await FirebaseConstants.FollowingCOlelction.document(uid).collection("user-following").getDocuments()
        let followCount = try await followingSnapshot.count
        
        async let followersSnapshot = try await FirebaseConstants.FollowersCollection.document(uid).collection("user-followes").getDocuments()
        let followerCount = try await followersSnapshot.count
        
        async let postSnapshot = try await FirebaseConstants.PostsCollection.whereField("ownerUid", isEqualTo: uid).getDocuments()
        let postCount = try await postSnapshot.count
        
        return .init(followingCount: followCount, follwersCount: followerCount, postsCount: postCount)
    }
}
