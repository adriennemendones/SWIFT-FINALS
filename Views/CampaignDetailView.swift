import SwiftUI

struct CampaignDetailView: View {
    let campaignCategory: CampaignCategory
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // Campaign Image
                ZStack(alignment: .topLeading) {
                    Image("typhoon") // Replace with your campaign image
                        .resizable()
                        .scaledToFill()
                        .frame(height: 300)
                        .clipped()
                    
                    // Back Button
                    Button(action: {
                        // Back action if needed
                    }) {
                        Image(systemName: "arrow.left")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .padding()
                            .background(Color.green)
                            .foregroundColor(.white)
                            .clipShape(Circle())
                    }
                    .padding()
                }
                
                // Campaign Info
                VStack(alignment: .leading, spacing: 20) {
                    Text(campaignCategory.title)
                        .font(.title)
                        .fontWeight(.bold)
                    
                    // Progress Bar
                    VStack(alignment: .leading, spacing: 5) {
                        HStack {
                            Text("Raised so Far")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                            Spacer()
                            Text("Target")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                        
                        HStack {
                            Text("₱137,572")
                                .font(.headline)
                            Spacer()
                            Text("₱200,000")
                                .font(.headline)
                        }
                        
                        // Progress Bar
                        ProgressView(value: 137572, total: 200000)
                            .progressViewStyle(LinearProgressViewStyle(tint: .green))
                    }
                    
                    // Donate Button
                    Button(action: {
                        // Navigate to donate page
                    }) {
                        Text("DONATE TO THIS CAMPAIGN")
                            .font(.headline)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.green)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    
                    // About Campaign
                    VStack(alignment: .leading, spacing: 10) {
                        Text("About Campaign")
                            .font(.headline)
                        
                        Text("""
                        Details about the \(campaignCategory.title) campaign will go here. This is an example placeholder description.
                        """)
                            .font(.body)
                            .foregroundColor(.gray)
                        
                        Button(action: {
                            // Navigate to detailed campaign info
                        }) {
                            Text("Read More")
                                .font(.body)
                                .foregroundColor(.green)
                                .padding(.horizontal, 10)
                                .padding(.vertical, 5)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.green, lineWidth: 1)
                                )
                        }
                    }
                }
                .padding()
            }
        }
        .edgesIgnoringSafeArea(.top)
    }
}
