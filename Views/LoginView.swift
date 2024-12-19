import SwiftUI
import FirebaseAuth

struct LoginView: View {
    @Binding var currentShowingView: String
    @Binding var isShowingSignup: Bool
    
    @AppStorage("uid") var userID: String = ""
    
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var showPassword = false
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    var body: some View {
        VStack {
            // Top section with back button
            HStack {
                Button(action: {
                    withAnimation {
                        currentShowingView = "home"
                    }
                }) {
                    Image(systemName: "arrow.left")
                        .foregroundColor(.green)
                        .imageScale(.large)
                        .padding()
                }
                Spacer()
            }
            .padding(.top, 30)
            
            // Logo Image
            Image("ecologo")
                .resizable()
                .scaledToFit()
                .frame(width: 120, height: 120)
                .padding(.top, 10)
            
            Text("LOG IN TO YOUR ACCOUNT")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(.green)
                .padding(.top, 5)
            
            Spacer()
            
            // Email and Password Fields
            VStack(spacing: 20) {
                HStack {
                    Image(systemName: "envelope")
                        .foregroundColor(.gray)
                    TextField("Email Address", text: $email)
                        .autocapitalization(.none) // Disable autocapitalization
                        .foregroundColor(.black)
                        .keyboardType(.emailAddress)
                        .disableAutocorrection(true)
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(lineWidth: 1)
                        .foregroundColor(.gray)
                )
                
                HStack {
                    Image(systemName: "lock")
                        .foregroundColor(.gray)
                    if showPassword {
                        TextField("Password", text: $password)
                            .foregroundColor(.black)
                    } else {
                        SecureField("Password", text: $password)
                            .foregroundColor(.black)
                    }
                    
                    Button(action: {
                        showPassword.toggle() // Toggle password visibility
                    }) {
                        Image(systemName: showPassword ? "eye" : "eye.slash")
                            .foregroundColor(.gray)
                    }
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(lineWidth: 1)
                        .foregroundColor(.gray)
                )
            }
            .padding(.horizontal, 40)
            .padding(.top, -10)
            
            Spacer()
            
            // Log In Button
            Button(action: {
                Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                    if error != nil {
                        alertMessage = "Incorrect email or password. Please try again."
                        showAlert = true
                        return
                    }
                    
                    // Successful login
                    if let authResult = authResult {
                        userID = authResult.user.uid
                    }
                }
            }) {
                Text("Log In")
                    .foregroundColor(.white)
                    .bold()
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.green)
                    .cornerRadius(10)
            }
            .padding(.horizontal, 40)
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Login Error"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
            }
            
            // Signup Link
            HStack(spacing: 4) {
                Text("Don't have an account?")
                    .foregroundColor(.gray)
                    .font(.footnote)
                Button(action: {
                    isShowingSignup = true // Show Signup as a sheet
                }) {
                    Text("Create Account")
                        .font(.body)
                        .fontWeight(.semibold)
                        .foregroundColor(.green)
                }
            }
            .padding(.top, 5)
            
            Spacer()
        }
        .background(Color.white)
        .ignoresSafeArea()
        .sheet(isPresented: $isShowingSignup) {
            SignupView(currentShowingView: $currentShowingView, isPresented: $isShowingSignup)
        }
    }
}

#Preview {
    LoginView(currentShowingView: .constant("login"), isShowingSignup: .constant(false))
}
