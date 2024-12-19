import SwiftUI

struct IntroView: View {
    var onGetStarted: () -> Void
    
    var body: some View {
        VStack(spacing: 20) {
            Spacer() // This spacer will push content lower on the screen
            
            Image("ecologo") // Updated to use ecologo.png
                .resizable()
                .scaledToFit()
                .frame(width: 150, height: 150)

            Text("ECOnnect")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.green)
            
            Text("Connect with others to fund impactful projects that drive environmental change and sustainability. Together, we can build a greener future.")
                .multilineTextAlignment(.center)
                .foregroundColor(.gray)
                .padding(.horizontal, 40)
            
            Spacer() // Adjusts spacing between text and button
            
            Button(action: {
                onGetStarted() // Trigger navigation to auth flow
            }) {
                Text("Get Started")
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.green)
                    .cornerRadius(10)
                    .padding(.horizontal, 40)
            }
            
            Spacer() // This spacer will keep some space below the button
        }
        .padding(.top, 20) // Additional padding to control top space if needed
    }
}

#Preview {
    IntroView(onGetStarted: {})
}

//
