import SwiftUI

struct CampaignCardView: View {
    var imageName: String
    var title: String
    var organization: String
    var raisedAmount: Int
    var targetAmount: Int
    var daysLeft: Int
    var location: String // Location property

    @State private var isSharing: Bool = false // State for showing the share sheet

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            // Campaign Image and Details
            HStack(alignment: .top) {
                Image(imageName)
                    .resizable()
                    .frame(width: 80, height: 80)
                    .cornerRadius(10)

                VStack(alignment: .leading, spacing: 5) {
                    Text("\(daysLeft) days left")
                        .font(.caption)
                        .foregroundColor(.gray)

                    Text(title)
                        .font(.headline)
                        .fontWeight(.bold)

                    Text(organization)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }

                Spacer()
            }

            // Location
            HStack {
                Image(systemName: "mappin.and.ellipse")
                    .foregroundColor(.red)
                Text(location) // Display the location here
                    .font(.footnote)
                    .foregroundColor(.gray)
            }

            // Progress Bar and Raised Amount
            VStack(alignment: .leading, spacing: 5) {
                ProgressView(value: Float(raisedAmount) / Float(targetAmount))
                    .progressViewStyle(LinearProgressViewStyle(tint: .green))

                Text("₱\(formattedAmount(raisedAmount)) raised of ₱\(formattedAmount(targetAmount))")
                    .font(.footnote)
                    .foregroundColor(.gray)
            }

            // More Button
            HStack {
                Spacer()

                NavigationLink(
                    destination: DonateNowView(
                        imageName: imageName,
                        title: title,
                        organization: organization,
                        raisedAmount: raisedAmount,
                        targetAmount: targetAmount,
                        daysLeft: daysLeft
                    )
                ) {
                    HStack {
                        Text("More")
                            .font(.subheadline)
                            .fontWeight(.bold)
                        Image(systemName: "arrow.right")
                            .font(.subheadline)
                    }
                    .padding(.horizontal)
                    .padding(.vertical, 5)
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(20)
                }
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(15)
        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
        .contextMenu {
            Button(action: {
                isSharing = true // Show the share sheet
            }) {
                Label("Share", systemImage: "square.and.arrow.up")
            }
        }
        .sheet(isPresented: $isSharing) {
            ShareSheet(activityItems: ["Check out this campaign: \(title) by \(organization). Support it now!"])
        }
    }

    // MARK: - Helper Methods

    private func formattedAmount(_ amount: Int) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter.string(from: NSNumber(value: amount)) ?? "\(amount)"
    }
}

// MARK: - ShareSheet Wrapper
struct ShareSheet: UIViewControllerRepresentable {
    var activityItems: [Any]
    var applicationActivities: [UIActivity]? = nil

    func makeUIViewController(context: Context) -> UIActivityViewController {
        UIActivityViewController(activityItems: activityItems, applicationActivities: applicationActivities)
    }

    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {}
}

// MARK: - Preview

struct CampaignCardView_Previews: PreviewProvider {
    static var previews: some View {
        CampaignCardView(
            imageName: "education_photo",
            title: "Futures Fund: College Dreams Campaign",
            organization: "AhonEduk Org",
            raisedAmount: 84572,
            targetAmount: 100000,
            daysLeft: 5,
            location: "Barangay Gulang-Gulang" // Add location in preview
        )
        .previewLayout(.sizeThatFits)
        .padding()
    }
}
