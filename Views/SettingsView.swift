import SwiftUI

struct SettingsView: View {
    @AppStorage("userEmail") var email: String = ""  // Access the email from @AppStorage
    @AppStorage("userName") var userName: String = "User Name"  // Placeholder for the user's name

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                // Header with centered title
                HStack {
                    Spacer()
                    Text("Settings")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                    Spacer()
                }
                .padding([.top, .leading, .trailing], 16)

                Divider().background(Color.gray)
                
                Spacer().frame(height: 30) // Space between title and balance display

                // Profile Section (Logo above, Name, then Email)
                VStack(spacing: 8) {
                    // Logo
                    Image("ecologo") // Replace with your logo asset name
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                        .accessibilityLabel("App Logo")
                        .padding(.bottom, 10) // Space between logo and name
                    
                    // User Name
                    Text(userName)  // Display the user name from @AppStorage
                        .font(.title)
                        .fontWeight(.bold)
                        .accessibilityLabel("Name: \(userName)")
                    
                    // Email
                    Text(email) // Display the email from @AppStorage
                        .font(.system(size: 16, weight: .light))  // Thinner font
                        .foregroundColor(.green) // Green color
                        .accessibilityLabel("Email: \(email)")
                }
                .padding(.top, 20)
                
                // Settings Options
                VStack(spacing: 16) {
                    // Navigation to Help & Support
                    NavigationLink(destination: HelpView()) {
                        SettingsOption(icon: "questionmark.circle", title: "Help & Support")
                    }
                    
                    // Navigation to Contact Us
                    NavigationLink(destination: ContactUsView()) {
                        SettingsOption(icon: "envelope", title: "Contact us")
                    }
                    
                    // Navigation to Privacy Policy
                    NavigationLink(destination: PrivacyPolicyView()) {
                        SettingsOption(icon: "lock.shield", title: "Privacy Policy")
                    }
                }
                .padding(.top, 30)
                
                Spacer()
            }
            .padding(.horizontal)
            .background(Color.white)
            .edgesIgnoringSafeArea(.bottom)
        }
    }
}

// Reusable Component for Settings Option
struct SettingsOption: View {
    let icon: String
    let title: String
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .resizable()
                .scaledToFit()
                .frame(width: 24, height: 24)
                .foregroundColor(.green)
                .accessibilityLabel(title)
            
            Text(title)
                .font(.headline)
            
            Spacer()
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color(UIColor.systemGray4), lineWidth: 1)
        )
    }
}

// Preview
struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
