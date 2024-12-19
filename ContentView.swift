import SwiftUI
import FirebaseAuth

struct ContentView: View {
    @AppStorage("uid") var userID: String = "" // Tracks login status
    
    @State private var showSplashScreen = true
    @State private var showIntroView = false
    
    var body: some View {
        if showSplashScreen {
            // Show Splash Screen initially
            SplashScreenView()
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        withAnimation {
                            showSplashScreen = false
                            showIntroView = true
                        }
                    }
                }
        } else if showIntroView {
            // Show Intro View after Splash Screen
            IntroView {
                withAnimation {
                    showIntroView = false
                }
            }
        } else {
            // Show AuthView if no user is logged in; otherwise, show HomeView
            if userID.isEmpty {
                AuthView()
            } else {
                HomeView()
            }
        }
    }
}

#Preview {
    ContentView()
}


//
