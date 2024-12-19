import SwiftUI
import FirebaseAuth

struct SignupView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    
    @Binding var currentShowingView: String
    @Binding var isPresented: Bool
    
    @State private var isAgreementChecked = false
    @State private var showAlert = false
    @State private var alertMessage = ""
    @State private var showPassword = false // Toggle for showing/hiding password
    
    @AppStorage("userEmail") var savedEmail: String = "" // Store the email in @AppStorage
    
    private var isSignupEnabled: Bool {
        return !email.isEmpty && !password.isEmpty && isAgreementChecked
    }
    
    private func isValidPassword(_ password: String) -> Bool {
        // Password validation: at least 6 characters, 1 uppercase, 1 special character
        let passwordRegex = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&])(?=.*[A-Z]).{6,}$")
        return passwordRegex.evaluate(with: password)
    }
    
    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    isPresented = false // Close Signup view
                }) {
                    Image(systemName: "arrow.left")
                        .foregroundColor(.green)
                        .padding()
                        .imageScale(.large)
                }
                Spacer()
            }
            .padding(.top, 30)
            
            Image("ecologo")
                .resizable()
                .scaledToFit()
                .frame(width: 120, height: 120)
                .padding(.top, 10)
            
            Text("CREATE AN ACCOUNT")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(.green)
                .padding(.top, 5)
            
            Spacer()
            
            VStack(spacing: 20) {
                HStack {
                    Image(systemName: "envelope")
                        .foregroundColor(.gray)
                    TextField("Email Address", text: $email)
                        .autocapitalization(.none)
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
            
            // Agreement Section
            VStack(spacing: 2) {
                HStack {
                    Button(action: {
                        isAgreementChecked.toggle()
                    }) {
                        Image(systemName: isAgreementChecked ? "checkmark.square.fill" : "square")
                            .foregroundColor(isAgreementChecked ? .green : .gray)
                    }
                    Text("I've read and agree to the")
                        .foregroundColor(.gray)
                        .font(.footnote)
                }
                
                HStack(spacing: 4) {
                    Button(action: {
                        // Action to show user agreement
                    }) {
                        Text("USER AGREEMENT")
                            .underline()
                            .foregroundColor(.green)
                            .font(.footnote)
                            .fontWeight(.semibold)
                    }
                    Text("and")
                        .foregroundColor(.gray)
                        .font(.footnote)
                    Button(action: {
                        // Action to show privacy policy
                    }) {
                        Text("PRIVACY POLICY")
                            .underline()
                            .foregroundColor(.green)
                            .font(.footnote)
                            .fontWeight(.semibold)
                    }
                }
            }
            .padding(.horizontal, 40)
            .padding(.top, 5)
            
            Spacer()
            
            // Create Account Button
            Button(action: {
                if !isValidPassword(password) {
                    alertMessage = "Password must be at least 6 characters long, contain 1 uppercase letter, and 1 special character."
                    showAlert = true
                    return
                }
                
                Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                    if let error = error {
                        alertMessage = error.localizedDescription
                        showAlert = true
                        return
                    }
                    
                    // Save the email in @AppStorage after successful signup
                    savedEmail = email
                    
                    // After successful signup, navigate to LoginView and close SignupView
                    withAnimation {
                        currentShowingView = "login"
                        isPresented = false // Close the Signup sheet automatically
                    }
                }
            }) {
                Text("Create New Account")
                    .foregroundColor(.white)
                    .bold()
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(isSignupEnabled ? Color.green : Color.green.opacity(0.6))
                    .cornerRadius(10)
                    .shadow(color: isSignupEnabled ? .green.opacity(0.3) : .clear, radius: 5, x: 0, y: 3)
            }
            .padding(.horizontal, 40)
            .disabled(!isSignupEnabled)
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Signup Error"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
            }
            
            Spacer()
        }
        .background(Color.white)
        .ignoresSafeArea()
    }
}

#Preview {
    SignupView(currentShowingView: .constant("signup"), isPresented: .constant(true))
}
