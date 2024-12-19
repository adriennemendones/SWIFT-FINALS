import SwiftUI

struct SplashScreenView: View {
    @State private var logoOpacity = 0.0
    
    var body: some View {
        VStack {
            Image("ecologo") // Updated to use ecologo.png
                .resizable()
                .scaledToFit()
                .frame(width: 150, height: 150)
                .opacity(logoOpacity)
                .onAppear {
                    withAnimation(.easeIn(duration: 1.5)) {
                        logoOpacity = 1.0
                    }
                }
            
            Text("ECOnnect")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(Color.green)
                .padding(.top, 20)
        }
        .background(Color.white)
        .ignoresSafeArea()
    }
}

#Preview {
    SplashScreenView()
}

//
