import Foundation

class DonationManager: ObservableObject {
    @Published var completedDonations: [DonatedCampaign] = []
}
