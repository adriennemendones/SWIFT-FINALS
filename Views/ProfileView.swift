import SwiftUI
import FirebaseFirestore
import FirebaseAuth
import FirebaseStorage

struct ProfileView: View {
    @AppStorage("uid") var userID: String = ""
    @AppStorage("userName") var name: String = ""  // Add @AppStorage for name persistence
    
    @State private var isAnonymous: Bool = false
    @State private var isLoading: Bool = false
    @State private var showAlert: Bool = false
    @State private var alertMessage: String = ""
    
    private var db = Firestore.firestore()
    private var storage = Storage.storage() // Retained Firebase Storage for other potential uses
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Profile Settings")
                .font(.title)
                .fontWeight(.bold)
                .padding(.top, 20)
            
            Divider()
            
            VStack(alignment: .leading, spacing: 20) {
                // Name Field
                VStack(alignment: .leading, spacing: 8) {
                    Text("Name")
                        .font(.headline)
                    
                    TextField("Enter your name", text: $name)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                
                // Anonymous Toggle
                Toggle(isOn: $isAnonymous) {
                    Text("Display as Anonymous")
                        .font(.headline)
                }
            }
            .padding(.horizontal, 30)
            .padding(.top, 20)
            
            // Save Button
            Button(action: saveProfile) {
                Text("Save Profile")
                    .foregroundColor(.white)
                    .bold()
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(isLoading ? Color.gray : Color.green)
                    .cornerRadius(10)
            }
            .padding(.horizontal, 30)
            .disabled(isLoading)
            
            Spacer()
        }
        .padding()
        .onAppear(perform: loadProfile)
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Profile"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
        }
        .navigationBarBackButtonHidden(false)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Image("ecologo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40, height: 40)
            }
        }
    }
    
    // MARK: - Load Profile Data
    private func loadProfile() {
        guard let userId = Auth.auth().currentUser?.uid else { return }
        
        isLoading = true
        db.collection("users").document(userId).getDocument { document, error in
            isLoading = false
            
            if let error = error {
                alertMessage = "Failed to load user profile: \(error.localizedDescription)"
                showAlert = true
                return
            }
            
            if let document = document, document.exists {
                name = document.data()?["name"] as? String ?? ""
                isAnonymous = document.data()?["isAnonymous"] as? Bool ?? false
            } else {
                alertMessage = "User profile does not exist."
                showAlert = true
            }
        }
    }
    
    // MARK: - Save Profile Data
    private func saveProfile() {
        guard let userId = Auth.auth().currentUser?.uid else { return }
        
        isLoading = true
        
        let data: [String: Any] = [
            "name": name,
            "isAnonymous": isAnonymous
        ]
        
        db.collection("users").document(userId).setData(data, merge: true) { error in
            isLoading = false
            
            if let error = error {
                alertMessage = "Failed to save profile: \(error.localizedDescription)"
                showAlert = true
            } else {
                alertMessage = "Profile saved successfully!"
                showAlert = true
            }
        }
    }
}

// Preview
struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}

//
