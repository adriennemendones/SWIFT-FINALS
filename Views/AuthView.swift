import SwiftUI
import FirebaseAuth

struct AuthView: View {
    @State private var currentViewShowing: String = "login" // Track current view
    @State private var isShowingSignup = false // Track signup sheet presentation
    
    @AppStorage("uid") var userID: String = ""
    
    var body: some View {
        if userID == "" {
            if currentViewShowing == "login" {
                LoginView(
                    currentShowingView: $currentViewShowing,
                    isShowingSignup: $isShowingSignup
                )
                .preferredColorScheme(.light)
            } else if currentViewShowing == "signup" {
                SignupView(
                    currentShowingView: $currentViewShowing,
                    isPresented: $isShowingSignup
                )
                .preferredColorScheme(.dark)
                .transition(.move(edge: .bottom))
            }
        } else {
            HomeView()
        }
    }
}

#Preview {
    AuthView()
}

//
