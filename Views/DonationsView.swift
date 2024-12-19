import SwiftUI

struct DonationsView: View {
    @AppStorage("donatedCampaigns") private var donatedCampaignsData: Data = Data() // Persist donated campaigns
    @State private var donatedCampaigns: [Campaign] = [] // Holds the donated campaigns

    var body: some View {
        VStack(spacing: 20) {
            // Title
            Text("Your Donations")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.top)

            // Scrollable donation cards
            if donatedCampaigns.isEmpty {
                Text("No donations yet.")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .padding(.top, 20)
            } else {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 20) {
                        ForEach(donatedCampaigns) { campaign in
                            DonationCardView(
                                imageName: campaign.imageName,
                                title: campaign.title,
                                organization: campaign.organization,
                                raisedAmount: campaign.raisedAmount,
                                targetAmount: campaign.targetAmount,
                                daysLeft: campaign.daysLeft,
                                location: campaign.location
                            )
                        }
                    }
                    .padding(.horizontal)
                }
            }

            Spacer()
        }
        .padding(.top)
        .onAppear(perform: loadDonatedCampaigns) // Load donated campaigns when the view appears
    }

    // MARK: - Load Donated Campaigns
    private func loadDonatedCampaigns() {
        do {
            donatedCampaigns = try JSONDecoder().decode([Campaign].self, from: donatedCampaignsData)
        } catch {
            print("Failed to load donated campaigns: \(error.localizedDescription)")
        }
    }
}

struct DonationCardView: View {
    let imageName: String
    let title: String
    let organization: String
    let raisedAmount: Int
    let targetAmount: Int
    let daysLeft: Int
    let location: String

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Image(imageName)
                .resizable()
                .scaledToFill()
                .frame(width: 200, height: 120)
                .clipped()
                .cornerRadius(10)

            VStack(alignment: .leading, spacing: 5) {
                Text(title)
                    .font(.headline)
                    .lineLimit(2)

                Text("By \(organization)")
                    .font(.subheadline)
                    .foregroundColor(.gray)

                HStack {
                    Image(systemName: "mappin.and.ellipse")
                        .foregroundColor(.red)
                    Text(location)
                        .font(.footnote)
                        .foregroundColor(.gray)
                }

                HStack {
                    Text("₱\(raisedAmount.formatted()) raised of ₱\(targetAmount.formatted())")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }

                HStack {
                    ProgressBarView(progress: Double(raisedAmount) / Double(targetAmount))
                        .frame(height: 8)

                    Text("\(daysLeft) days left")
                        .font(.caption)
                        .foregroundColor(.red)
                }
            }
            .padding(.horizontal)
            .padding(.bottom, 10)
        }
        .frame(width: 200)
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
    }
}

struct ProgressBarView: View {
    let progress: Double

    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: 5)
                    .fill(Color.gray.opacity(0.3))
                    .frame(height: 8)

                RoundedRectangle(cornerRadius: 5)
                    .fill(Color.green)
                    .frame(width: geometry.size.width * CGFloat(progress), height: 8)
            }
        }
    }
}

#Preview {
    DonationsView()
}
