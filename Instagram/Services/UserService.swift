
import Firebase
import Foundation
import FirebaseAuth

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
    
    static func fetchUsers(forConfig config: UserListConfig) async throws -> [User] {
        switch config {
            
        case .followers(uid: let uid):
            return try await fetchFollowers(uid: uid)
        case .following(uid: let uid):
            return try await fetchFollowers(uid: uid)
        case .likes(postId: let postId):
            return try await fetchPostLikeUsers(postID: postId)
        case .explore:
            return try await fetchAllUsers()
        }    }
    
    private static func fetchFollowers(uid: String) async throws -> [User] {
        guard let currentUid = Auth.auth().currentUser?.uid else { return [] }
        let snapshot = try await FirebaseConstants
            .FollowersCollection
            .document(uid)
            .collection("user-followers")
            .getDocuments()

        return  try await fetchUsers(snapshot)
    }
    
    private static func fetchFollowing(uid: String) async throws -> [User] {
        let snapshot = try await FirebaseConstants
            .FollowingCOlelction
            .document(uid)
            .collection("user-following")
            .getDocuments()
        return  try await fetchUsers(snapshot)
    }
    
    private static func fetchPostLikeUsers(postID: String) async throws -> [User] {
        
        return []
    }
    private static func fetchUsers(_ snapshot: QuerySnapshot) async throws -> [User] {
        var users = [User]()
        for doc in snapshot.documents {
            users.append(try await fetchUser(withUid: doc.documentID))
        }
        return users
    }
}

extension UserService {
    static func follow(uid: String) async throws {
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        
        async let _ = try await FirebaseConstants.FollowingCOlelction.document(currentUid).collection("user-following").document(uid).setData([:])
        async let _ = try await FirebaseConstants.FollowersCollection.document(uid).collection("user-followers").document(currentUid).setData([:])
        print("Successfully followed user: \(uid)")
        
    }
    
    static func unfollow(uid: String) async throws {
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        async let _ = try await FirebaseConstants.FollowingCOlelction.document(currentUid).collection("user-following").document(uid).delete()
        async let _ = try await FirebaseConstants.FollowersCollection.document(uid).collection("user-followers").document(currentUid).delete()
    }
    
    static func checkIFuserisFollowed(uid: String ) async throws -> Bool {
        guard let currentUid = Auth.auth().currentUser?.uid else { return false}
        let snapshot = try await FirebaseConstants.FollowingCOlelction.document(currentUid).collection("user-following").document(uid).getDocument()
        print(snapshot)
        return snapshot.exists
    }
}


extension UserService {
    
}

// Mark: - User Stats

extension UserService {
    static func fetchUserStats(uid: String) async throws -> UserStats {
        print("Fetching stats for user: \(uid)")
        
        async let followingCount = try await FirebaseConstants.FollowingCOlelction.document(uid).collection("user-following").getDocuments().count
        
        async let followerCount = try await FirebaseConstants.FollowersCollection.document(uid).collection("user-followers").getDocuments().count
        
        async let postCount =  FirebaseConstants.PostsCollection.whereField("ownerUid", isEqualTo: uid).getDocuments().count
        
        let stats = try await UserStats(followingCount: followingCount, follwersCount: followerCount, postsCount: postCount)
        return stats
    }
}
