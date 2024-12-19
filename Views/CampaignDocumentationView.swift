import SwiftUI

struct CampaignDocumentationView: View {
    var iconName: String
    var title: String
    var date: String
    
    var body: some View {
        HStack {
            Image(systemName: iconName)
                .font(.title)
                .foregroundColor(.white)
                .padding()
                .background(Color.green)
                .clipShape(Circle())
            VStack(alignment: .leading) {
                Text(title)
                    .font(.subheadline)
                    .fontWeight(.bold)
                Text(date)
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            Spacer()
            Image(systemName: "chevron.right")
                .foregroundColor(.gray)
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(10)
    }
}

//
