import Foundation
import FirebaseAuth
import SwiftUI

class UserProfile: ObservableObject {
    @AppStorage("userName") var userName: String = ""
    @AppStorage("userEmail") var userEmail: String = ""
    
    // Method to fetch user details from Firebase
    func fetchUserDetails() {
        if let currentUser = Auth.auth().currentUser {
            self.userName = currentUser.displayName ?? "User Name"
            self.userEmail = currentUser.email ?? "No email available"
        }
    }
    
    // Reset user details (e.g. for logout)
    func resetUserDetails() {
        self.userName = ""
        self.userEmail = ""
    }
}
