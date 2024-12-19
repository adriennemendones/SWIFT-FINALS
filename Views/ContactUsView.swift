import SwiftUI

struct ContactUsView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 40) {
                // Title
                Text("Contact Us")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    .padding(.top, 30) // Adjust top padding as needed
                
                // Description
                VStack(alignment: .center, spacing: 20) {
                    Text("""
                    Don’t hesitate to contact us whether you have a suggestion on our improvement, a complaint to discuss, or an issue to solve.
                    """)
                    .multilineTextAlignment(.center)
                    .font(.body)
                    .padding(.horizontal)
                    .foregroundColor(.black)
                }
                .padding(.top, 50) // Push description lower
                
                // Contact Methods
                HStack(spacing: 40) {
                    ContactMethodView(
                        icon: "phone.fill",
                        title: "Call us",
                        details: """
                        09257381920
                        Mon–Fri • 8AM–8PM
                        """
                    )
                    
                    ContactMethodView(
                        icon: "envelope.fill",
                        title: "Email us",
                        details: """
                        econnect24@gmail.com
                        Mon–Fri • 8AM–8PM
                        """
                    )
                }
                .padding(.top, 20) // Keep contact options slightly below the description
                
                Spacer(minLength: 50)
                
                // Footer Text
                Text("@EConnects Teams 2024")
                    .font(.footnote)
                    .foregroundColor(.green)
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.green, lineWidth: 1)
                    )
            }
            .padding(.horizontal)
        }
        .background(Color.white)
    }
}

// Reusable Component for Contact Method
struct ContactMethodView: View {
    let icon: String
    let title: String
    let details: String
    
    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: icon)
                .resizable()
                .scaledToFit()
                .frame(width: 50, height: 50)
                .padding()
                .background(Color.green)
                .cornerRadius(10)
                .foregroundColor(.white)
            
            Text(title)
                .font(.headline)
                .foregroundColor(.black)
            
            Text(details)
                .font(.subheadline)
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
        }
    }
}

// Preview
struct ContactUsView_Previews: PreviewProvider {
    static var previews: some View {
        ContactUsView()
    }
}
