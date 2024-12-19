enum CampaignCategory: CaseIterable {
    case education, animal, health, shelter, disaster
    
    var title: String {
        switch self {
        case .education: return "Education"
        case .animal: return "Animal"
        case .health: return "Health"
        case .shelter: return "Shelter"
        case .disaster: return "Disaster"
        }
    }
    
    var iconName: String {
        switch self {
        case .education: return "graduationcap.fill"
        case .animal: return "pawprint.fill"
        case .health: return "heart.fill"
        case .shelter: return "house.fill"
        case .disaster: return "exclamationmark.triangle.fill"
        }
    }
}

//
