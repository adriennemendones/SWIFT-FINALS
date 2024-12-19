import SwiftUI

struct UrgentNeedCardView: View {
    var imageName: String
    var title: String
    var organization: String
    var raisedAmount: Int
    var targetAmount: Int
    var daysLeft: Int
    
    var body: some View {
        VStack(alignment: .leading) {
            Image(systemName: "photo") // Placeholder image
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 150, height: 100)
                .cornerRadius(10)
            Text(organization)
                .font(.footnote)
                .foregroundColor(.gray)
            Text("\(daysLeft) days left")
                .font(.caption)
                .foregroundColor(.red)
            Text(title)
                .font(.subheadline)
                .fontWeight(.bold)
            ProgressView(value: Double(raisedAmount), total: Double(targetAmount))
                .progressViewStyle(LinearProgressViewStyle(tint: .green))
            Text("₱\(raisedAmount) raised of ₱\(targetAmount)")
                .font(.caption)
                .foregroundColor(.gray)
        }
        .frame(width: 160)
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 2)
    }
}

//
