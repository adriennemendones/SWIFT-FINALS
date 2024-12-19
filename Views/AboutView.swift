// AboutView.swift

import SwiftUI

struct AboutView: View {
    var body: some View {
        VStack(spacing: 20) {
            // Title
            Text("About")
                .font(.title)
                .fontWeight(.bold)
                .padding(.top, 20)
            Divider()
            
            // App Description
            Text("EConnect is a crowdfunding application for social causes designed exclusively for Lucena, Quezon, Philippines, to facilitate both monetary donations and in-kind contributions, ensuring robust support for a wide range of initiatives.")
                .multilineTextAlignment(.center)
                .foregroundColor(.gray)
                .padding(.horizontal, 30)
            
            Text("The application features Fund Tracking, Social Media Integration, Community Engagement Tools, User-Friendly Interface, Contribution Payment Options, and Feedback and Review System.")
                .multilineTextAlignment(.center)
                .foregroundColor(.gray)
                .padding(.horizontal, 30)
                .padding(.top, 10)
            
            // Team Section
            Text("Our Team")
                .font(.headline)
                .padding(.top, 20)
            
            HStack(spacing: 30) {
                TeamMemberView(imageName: "adri", name: "Adrienne Mendones", role: "UI/UX Designer")
                TeamMemberView(imageName: "glenn", name: "Glenn Uy Oreto", role: "UI/UX Designer")
            }
            
            Spacer()
        }
        .padding()
        .navigationBarBackButtonHidden(false) // Allows system back button
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Image("ecologo") // Replace with the actual logo image name
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40, height: 40)
            }
        }
    }
}

struct TeamMemberView: View {
    var imageName: String
    var name: String
    var role: String
    
    var body: some View {
        VStack(spacing: 5) {
            Image(imageName) // Replace with actual image names: "adri" and "glenn"
                .resizable()
                .frame(width: 80, height: 80)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.green, lineWidth: 2))
            
            Text(name)
                .font(.headline)
            Text(role)
                .font(.subheadline)
                .foregroundColor(.gray)
        }
    }
}

#Preview {
    NavigationView {
        AboutView()
    }
}

//
