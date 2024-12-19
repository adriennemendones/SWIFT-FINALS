import SwiftUI

struct PrivacyPolicyView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .center, spacing: 20) { // Center alignment for the title
                // Title
                Text("Privacy Policy")
                    .font(.largeTitle)
                    .fontWeight(.bold) // Make the title bold
                    .multilineTextAlignment(.center) // Center the text
                    .padding(.top, 30) // Add space at the top
                
                // Privacy Policy Content
                VStack(alignment: .leading, spacing: 20) {
                    PrivacySection(
                        number: "1",
                        title: "Types of data we collect",
                        content: """
                        We collect the following types of data:
                        - Personal Information: This includes your name, email address, phone number, and billing details, which you provide during registration or transactions.
                        - Device Information: Details about the device you use to access our app, such as the operating system, IP address, and browser type.
                        - Usage Data: Information about how you use our app, including pages visited, time spent on specific features, and actions taken.
                        """
                    )
                    
                    PrivacySection(
                        number: "2",
                        title: "Use of your personal data",
                        content: """
                        We use your personal data to:
                        - Provide and maintain the app, ensuring its functionality and security.
                        - Customize your experience by personalizing features and content based on your preferences.
                        - Communicate with you about updates, promotions, and support-related inquiries.
                        - Analyze user behavior to improve our services and develop new features.
                        - Comply with legal obligations, such as fraud prevention and regulatory requirements.
                        """
                    )
                    
                    PrivacySection(
                        number: "3",
                        title: "Disclosure of your personal data",
                        content: """
                        We may share your personal data in the following circumstances:
                        - Service Providers: With trusted third-party providers who assist us with app functionality, analytics, and payment processing.
                        - Legal Obligations: When required by law, such as responding to a subpoena or protecting our legal rights.
                        - Business Transfers: In the event of a merger, acquisition, or sale of assets, your data may be transferred to the new entity.
                        
                        We ensure that any third parties accessing your data are bound by strict confidentiality agreements.
                        """
                    )
                    
                    PrivacySection(
                        number: "4",
                        title: "Data retention policy",
                        content: """
                        We retain your personal data for as long as necessary to:
                        - Fulfill the purposes for which it was collected.
                        - Comply with legal obligations.
                        - Resolve disputes and enforce our agreements.
                        
                        Once the retention period expires, we securely delete or anonymize your data.
                        """
                    )
                    
                    PrivacySection(
                        number: "5",
                        title: "Your rights regarding your data",
                        content: """
                        You have the following rights regarding your personal data:
                        - Access: Request a copy of the data we have collected about you.
                        - Correction: Update inaccurate or incomplete personal data.
                        - Deletion: Request the deletion of your personal data, subject to certain legal or contractual obligations.
                        - Data Portability: Obtain your data in a portable format to transfer to another service provider.
                        
                        To exercise your rights, please contact our support team.
                        """
                    )
                }
                .padding(.horizontal)
            }
            .padding(.bottom, 20)
        }
        .background(Color.white)
    }
}

// Reusable Component for Privacy Section
struct PrivacySection: View {
    let number: String
    let title: String
    let content: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("\(number). \(title)")
                .font(.headline)
                .foregroundColor(.green)
            
            Text(content)
                .font(.body)
                .foregroundColor(.black)
        }
    }
}

// Preview
struct PrivacyPolicyView_Previews: PreviewProvider {
    static var previews: some View {
        PrivacyPolicyView()
    }
}
