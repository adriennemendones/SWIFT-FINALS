// FeedbackView.swift

import SwiftUI

struct FeedbackView: View {
    @State private var feedbackText: String = ""
    @State private var rating: Int = 0
    @State private var showAlert = false
    @State private var alertMessage = ""

    var body: some View {
        VStack(spacing: 20) {
            // Title and Description
            Text("Feedback")
                .font(.title)
                .fontWeight(.bold)
                .padding(.top, 20)
            Divider()
            
            Text("How did we do?")
                .font(.headline)
            
            Text("We'd love to hear about your experience with our platform. Please take a moment to share your thoughts with us.")
                .multilineTextAlignment(.center)
                .foregroundColor(.gray)
                .padding(.horizontal, 30)
            
            // Rating Section
            Text("Rate your experience")
                .font(.headline)
            
            HStack(spacing: 10) {
                ForEach(1...5, id: \.self) { star in
                    Image(systemName: star <= rating ? "star.fill" : "star")
                        .font(.title)
                        .foregroundColor(.green)
                        .onTapGesture {
                            rating = star
                        }
                }
            }
            
            // Comment Box
            VStack(alignment: .center) {
                Text("Write your comment (optional)")
                    .font(.headline)
                    .padding(.bottom, 5)
                
                TextEditor(text: $feedbackText)
                    .frame(height: 100)
                    .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.green, lineWidth: 1))
                    .foregroundColor(.black)
                    .padding(.horizontal, 30)
            }
            
            // Submit Button
            Button(action: submitFeedback) {
                Text("Send your Feedback")
                    .foregroundColor(.white)
                    .bold()
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.green)
                    .cornerRadius(10)
            }
            .padding(.horizontal, 30)
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Thank you!"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
            }
            
            Spacer()
        }
        .padding()
        .navigationBarBackButtonHidden(false) // Allows system back button
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Image("ecologo") // Replace with the actual logo image name
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40, height: 40)
            }
        }
    }
    
    // Submit Feedback Action
    private func submitFeedback() {
        if rating == 0 && feedbackText.isEmpty {
            alertMessage = "Please provide a rating or comment."
        } else {
            alertMessage = "Your feedback has been submitted."
            rating = 0
            feedbackText = ""
        }
        showAlert = true
    }
}

#Preview {
    NavigationView {
        FeedbackView()
    }
}

//
