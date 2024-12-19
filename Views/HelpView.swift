import SwiftUI

struct HelpView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .center, spacing: 20) {
                // Title
                Text("Help & Support")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    .padding(.top, 30)
                
                // Description
                VStack(alignment: .center, spacing: 20) {
                    Text("""
                    If you need assistance with our app, you can find answers to common questions, troubleshoot issues, or contact our support team.
                    """)
                    .multilineTextAlignment(.center)
                    .font(.body)
                    .padding(.horizontal)
                    .foregroundColor(.black)
                }
                .padding(.top, 50)
                
                // Help Topics
                VStack(alignment: .leading, spacing: 20) {
                    HelpTopicView(
                        icon: "book.fill",
                        title: "FAQ",
                        description: "Find answers to the most frequently asked questions about our app."
                    )
                    
                    HelpTopicView(
                        icon: "hammer.fill",
                        title: "Troubleshooting",
                        description: "Follow our guides to resolve technical issues you may encounter."
                    )
                    
                    HelpTopicView(
                        icon: "person.fill.questionmark",
                        title: "Contact Support",
                        description: "Reach out to our support team for further assistance."
                    )
                }
                .padding(.horizontal)
                
                Spacer(minLength: 50)
            }
            .padding(.vertical)
        }
        .background(Color.white)
    }
}

// Reusable Component for Help Topics
struct HelpTopicView: View {
    let icon: String
    let title: String
    let description: String
    
    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            Image(systemName: icon)
                .resizable()
                .scaledToFit()
                .frame(width: 40, height: 40)
                .foregroundColor(.green)
            
            VStack(alignment: .leading, spacing: 5) {
                Text(title)
                    .font(.headline)
                    .foregroundColor(.black)
                
                Text(description)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color(UIColor.systemGray4), lineWidth: 1)
        )
    }
}

// Preview
struct HelpView_Previews: PreviewProvider {
    static var previews: some View {
        HelpView()
    }
}
