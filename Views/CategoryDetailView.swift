import SwiftUI

struct CategoryDetailView: View {
    var category: CampaignCategory

    // Dummy data for campaigns
    private var campaigns: [Campaign] {
        switch category {
        case .education:
            return [
                Campaign(imageName: "education1", title: "Futures Fund: College Dreams Campaign", organization: "AhonEduk Org", raisedAmount: 84572, targetAmount: 100000, daysLeft: 5, location: "Barangay 1"),
                Campaign(imageName: "education2", title: "Books for All: Literacy Campaign", organization: "ReadNow Foundation", raisedAmount: 52000, targetAmount: 75000, daysLeft: 10, location: "Barangay 2"),
                Campaign(imageName: "education3", title: "Sponsor a Scholar Program", organization: "EduCare", raisedAmount: 90000, targetAmount: 120000, daysLeft: 7, location: "Barangay Gulang-Gulang"),
                Campaign(imageName: "education4", title: "Build a School Initiative", organization: "HelpBuildOrg", raisedAmount: 150000, targetAmount: 200000, daysLeft: 15, location: "Barangay Isabang"),
                Campaign(imageName: "education5", title: "Tech for All: Laptops for Kids", organization: "FutureReady", raisedAmount: 40000, targetAmount: 60000, daysLeft: 20, location: "Barangay Kanlurang Mayao")
            ]
        case .animal:
            return [
                Campaign(imageName: "animal1", title: "Paws and Claws Rescue Fund", organization: "PetRescue Org", raisedAmount: 30000, targetAmount: 50000, daysLeft: 3, location: "Barangay Ibabang Dupay"),
                Campaign(imageName: "animal2", title: "Vaccination Drive for Strays", organization: "VetCare Org", raisedAmount: 20000, targetAmount: 40000, daysLeft: 8, location: "Barangay Mayao Kanluran"),
                Campaign(imageName: "animal3", title: "Adopt a Pet Program", organization: "ForeverHome Org", raisedAmount: 35000, targetAmount: 45000, daysLeft: 12, location: "Barangay Ibabang Talim"),
                Campaign(imageName: "animal4", title: "Shelter Renovation Project", organization: "SafeHaven Org", raisedAmount: 50000, targetAmount: 70000, daysLeft: 18, location: "Barangay Ilayang Dupay"),
                Campaign(imageName: "animal5", title: "Emergency Surgery for Rescues", organization: "Care4Paws", raisedAmount: 45000, targetAmount: 60000, daysLeft: 5, location: "Barangay Ibabang Dupay")
            ]
        case .health:
            return [
                Campaign(imageName: "health1", title: "Medical Aid for Typhoon Victims", organization: "HealthPlus Org", raisedAmount: 75000, targetAmount: 100000, daysLeft: 6, location: "Barangay 4"),
                Campaign(imageName: "health2", title: "Support for Cancer Patients", organization: "LifeCare Org", raisedAmount: 120000, targetAmount: 150000, daysLeft: 20, location: "Barangay Ilayang Talim"),
                Campaign(imageName: "health3", title: "Free Check-Up Drive", organization: "HealthyMe Org", raisedAmount: 25000, targetAmount: 50000, daysLeft: 14, location: "Barangay Mayao Silangan"),
                Campaign(imageName: "health4", title: "Blood Donation Awareness", organization: "GiveBlood Org", raisedAmount: 45000, targetAmount: 60000, daysLeft: 10, location: "Barangay 5"),
                Campaign(imageName: "health5", title: "Mobile Clinics for Rural Areas", organization: "CareMobile", raisedAmount: 80000, targetAmount: 120000, daysLeft: 15, location: "Barangay Mayao Crossing")
            ]
        case .shelter:
            return [
                Campaign(imageName: "shelter1", title: "Homes for Homeless Families", organization: "ShelterHope Org", raisedAmount: 85000, targetAmount: 100000, daysLeft: 12, location: "Barangay Ilayang Iyam"),
                Campaign(imageName: "shelter2", title: "Disaster Relief Housing", organization: "SafeHaven Org", raisedAmount: 120000, targetAmount: 150000, daysLeft: 18, location: "Barangay Domoit"),
                Campaign(imageName: "shelter3", title: "Rebuilding After the Storm", organization: "RebuildTogether", raisedAmount: 95000, targetAmount: 120000, daysLeft: 10, location: "Barangay Market View"),
                Campaign(imageName: "shelter4", title: "Blanket and Supply Drive", organization: "Warmth4All", raisedAmount: 30000, targetAmount: 50000, daysLeft: 7, location: "Barangay 6"),
                Campaign(imageName: "shelter5", title: "Temporary Housing for Evacuees", organization: "HelpNow Org", raisedAmount: 60000, targetAmount: 80000, daysLeft: 15, location: "Barangay 9")
            ]
        case .disaster:
            return [
                Campaign(imageName: "disaster1", title: "Relief for Earthquake Victims", organization: "QuakeRelief Org", raisedAmount: 90000, targetAmount: 120000, daysLeft: 5, location: "Barangay 1"),
                Campaign(imageName: "disaster2", title: "Flood Recovery Fund", organization: "FloodCare Org", raisedAmount: 80000, targetAmount: 100000, daysLeft: 7, location: "Barangay Ilayang Dupay"),
                Campaign(imageName: "disaster3", title: "Typhoon Emergency Kits", organization: "StormSafe Org", raisedAmount: 40000, targetAmount: 60000, daysLeft: 3, location: "Barangay Mayao Crossing"),
                Campaign(imageName: "disaster4", title: "Fire Recovery Aid", organization: "BurnCare Org", raisedAmount: 50000, targetAmount: 70000, daysLeft: 12, location: "Barangay Mayao Silangan"),
                Campaign(imageName: "disaster5", title: "Drought Relief for Farmers", organization: "AgriAid Org", raisedAmount: 30000, targetAmount: 50000, daysLeft: 10, location: "Barangay Ibabang Dupay")
            ]
        }
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            // Title and Description
            Text("\(category.title) Campaigns")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.horizontal)

            Text(description(for: category))
                .font(.body)
                .foregroundColor(.gray)
                .padding(.horizontal)

            // Campaign List
            ScrollView {
                VStack(spacing: 20) {
                    ForEach(campaigns) { campaign in
                        CampaignCardView(
                            imageName: campaign.imageName,
                            title: campaign.title,
                            organization: campaign.organization,
                            raisedAmount: campaign.raisedAmount,
                            targetAmount: campaign.targetAmount,
                            daysLeft: campaign.daysLeft,
                            location: campaign.location // Pass the location here
                        )
                    }
                }
                .padding(.horizontal)
            }

            Spacer()
        }
        .navigationTitle(category.title)
        .navigationBarTitleDisplayMode(.inline)
    }

    // Descriptions for categories
    private func description(for category: CampaignCategory) -> String {
        switch category {
        case .education:
            return "Transform the lives of children by funding their education."
        case .animal:
            return "Provide crucial support for the rescue and care of animals."
        case .health:
            return "Improve lives by ensuring access to essential healthcare."
        case .shelter:
            return "Offer safety and security by funding shelter for those in need."
        case .disaster:
            return "Offer safety and security by funding disaster mitigations for those in need."
        }
    }
}

// Campaign Data Model
struct Campaign: Identifiable, Codable {
    let id = UUID()
    let imageName: String
    let title: String
    let organization: String
    let raisedAmount: Int
    let targetAmount: Int
    let daysLeft: Int
    let location: String
}

