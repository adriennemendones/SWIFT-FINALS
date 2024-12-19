import SwiftUI
import FirebaseAuth

struct SideMenuView: View {
    @Binding var isShowing: Bool
    @Binding var selectedView: SelectedView // Track the selected view for navigation
    @AppStorage("uid") var userID: String? // Tracks user ID for login status
    
    @State private var showLogoutConfirmation = false // State for showing the confirmation dialog
    @State private var userEmail: String = "" // State to hold the user's email
    
    // Fetch user details when the view appears
    func fetchUserDetails() {
        if let currentUser = Auth.auth().currentUser {
            userEmail = currentUser.email ?? "No email available"
        }
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            // Close Button and Logo
            HStack {
                Image("ecologo") // Placeholder for your logo
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40, height: 40)
                    .padding(.leading, 16)
                
                Spacer()
                
                Button(action: {
                    withAnimation {
                        isShowing = false
                    }
                }) {
                    Image(systemName: "xmark")
                        .foregroundColor(.black)
                        .padding()
                }
            }
            .padding(.top, 20)

            // User Email Section
            VStack(alignment: .leading) {
                VStack(alignment: .leading, spacing: 2) {
                    Text(userEmail) // Display the user's email only
                        .font(.headline)
                        .foregroundColor(.white.opacity(0.8))
                }
                .padding()
                .background(Color.green)
                .cornerRadius(12)
                .padding(.horizontal, 20)
            }
            .padding(.top, 10)

            // Side Menu Options
            VStack(alignment: .leading, spacing: 15) {
                // Navigation Links for each menu item
                NavigationLink(destination: ProfileView()) {
                    MenuButton(icon: "person.fill", title: "Profile", color: .green)
                }
                
                NavigationLink(destination: FeedbackView()) {
                    MenuButton(icon: "bubble.left.fill", title: "Feedback", color: .green)
                }
                
                NavigationLink(destination: AboutView()) {
                    MenuButton(icon: "info.circle.fill", title: "About", color: .green)
                }
                
                Divider().padding(.horizontal, 20)
                
                // Logout Button with Confirmation Dialog
                Button(action: {
                    showLogoutConfirmation = true // Trigger the confirmation dialog
                }) {
                    MenuButton(icon: "arrow.backward.circle.fill", title: "Logout", color: .red)
                }
                .alert(isPresented: $showLogoutConfirmation) {
                    Alert(
                        title: Text("Logout"),
                        message: Text("Are you sure you want to log out?"),
                        primaryButton: .destructive(Text("Logout")) {
                            // Perform logout
                            let firebaseAuth = Auth.auth()
                            do {
                                try firebaseAuth.signOut()
                                userID = nil // Clear userID to trigger SplashScreenView in ContentView
                                print("Logged out")
                            } catch let signOutError as NSError {
                                print("Error signing out: \(signOutError.localizedDescription)")
                            }
                        },
                        secondaryButton: .cancel()
                    )
                }
            }
            .padding(.leading, 20)

            Spacer()
            
            // Footer Section
            HStack {
                Spacer()
                Text("@EConnects Teams 2024")
                    .font(.footnote)
                    .foregroundColor(.green)
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.green, lineWidth: 1)
                    )
                Spacer()
            }
            .padding(.bottom, 10)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.white)
        .onAppear {
            fetchUserDetails() // Fetch user details when the view appears
        }
    }
}

// Reusable Menu Button Component
struct MenuButton: View {
    var icon: String
    var title: String
    var color: Color = .primary
    var action: (() -> Void)? = nil
    
    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: icon)
                .foregroundColor(color)
                .frame(width: 24, height: 24)
            
            Text(title)
                .foregroundColor(color)
                .font(.system(size: 18, weight: .medium))
        }
        .padding(.vertical, 8)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

// Preview
struct SideMenuView_Previews: PreviewProvider {
    @State static var isShowing = true
    @State static var selectedView: SelectedView = .home

    static var previews: some View {
        SideMenuView(isShowing: $isShowing, selectedView: $selectedView)
    }
}
