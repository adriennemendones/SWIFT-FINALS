import SwiftUI

struct DonateNowView: View {
    var imageName: String
    var title: String
    var organization: String
    var raisedAmount: Int
    var targetAmount: Int
    var daysLeft: Int

    @State private var selectedPaymentMethod: String? = nil // Track the selected payment method (nullable to allow deselection)
    @State private var isDonateButtonEnabled: Bool = false // Track if the donate button should be enabled
    @State private var navigateToEnterAmount = false // State for navigation

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 15) {
                // Campaign Image
                Image(imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 220)
                    .cornerRadius(10)
                    .shadow(radius: 5)

                // Campaign Title and Organization
                Text(title)
                    .font(.title2)
                    .fontWeight(.bold)
                    .padding(.bottom, 2)

                Text("Organized by \(organization)")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .padding(.bottom, 8)

                // Progress Bar and Raised Amount
                VStack(alignment: .leading, spacing: 5) {
                    ProgressView(value: Float(raisedAmount) / Float(targetAmount))
                        .progressViewStyle(LinearProgressViewStyle(tint: .green))
                        .frame(height: 6)
                        .cornerRadius(3)

                    Text("₱\(formattedAmount(raisedAmount)) raised of ₱\(formattedAmount(targetAmount))")
                        .font(.footnote)
                        .foregroundColor(.gray)
                }

                // Time Remaining
                Text("\(daysLeft) days left")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .padding(.top, 5)

                // Payment Method Selection
                VStack(alignment: .leading, spacing: 12) {
                    Text("Select Payment Method")
                        .font(.headline)
                        .padding(.top, 15)

                    HStack {
                        HStack {
                            Image(systemName: "banknote.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20, height: 20)
                                .padding(5)
                                .background(Color.green)
                                .cornerRadius(5)

                            Text("ECOnnect Wallet")
                                .font(.subheadline)
                                .foregroundColor(selectedPaymentMethod == "ECOnnect Wallet" ? .black : .gray)
                                .padding(.leading, 8)
                        }
                        .padding(.vertical, 5)
                        .frame(maxWidth: .infinity, alignment: .leading)

                        RadioButton(selectedPaymentMethod: $selectedPaymentMethod, option: "ECOnnect Wallet")
                            .frame(width: 30, height: 30)
                            .padding(.leading, 8)
                    }
                    .padding(.top, 10)
                }

                // Navigation to EnterAmountView
                NavigationLink(destination: EnterAmountView(), isActive: $navigateToEnterAmount) {
                    EmptyView()
                }
                .hidden()

                // Donate Now Button
                Button(action: {
                    if isDonateButtonEnabled {
                        navigateToEnterAmount = true // Navigate to EnterAmountView
                    }
                }) {
                    HStack {
                        Text("Donate Now")
                            .font(.headline)
                            .foregroundColor(.white)
                        Image(systemName: "heart.fill")
                            .foregroundColor(.white)
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(isDonateButtonEnabled ? Color.green : Color.gray)
                    .cornerRadius(10)
                }
                .disabled(!isDonateButtonEnabled)
                .padding(.top, 15)

                Spacer()
            }
            .padding(.horizontal)
        }
        .navigationBarTitle("Campaign Details", displayMode: .inline)
        .onChange(of: selectedPaymentMethod) { value in
            isDonateButtonEnabled = (selectedPaymentMethod == "ECOnnect Wallet")
        }
    }

    // Helper to format amounts with commas
    private func formattedAmount(_ amount: Int) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter.string(from: NSNumber(value: amount)) ?? "\(amount)"
    }
}

// MARK: - RadioButton View
struct RadioButton: View {
    @Binding var selectedPaymentMethod: String?
    var option: String

    var body: some View {
        Button(action: {
            // If the same option is clicked again, deselect it
            if selectedPaymentMethod == option {
                selectedPaymentMethod = nil
            } else {
                selectedPaymentMethod = option
            }
        }) {
            Circle()
                .strokeBorder(Color.green, lineWidth: 1)
                .background(Circle().fill(selectedPaymentMethod == option ? Color.green : Color.white))
                .frame(width: 16, height: 16)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

// MARK: - Preview
struct DonateNowView_Previews: PreviewProvider {
    static var previews: some View {
        DonateNowView(
            imageName: "education_photo",
            title: "Futures Fund: College Dreams Campaign",
            organization: "AhonEduk Org",
            raisedAmount: 84572,
            targetAmount: 100000,
            daysLeft: 5
        )
        .previewLayout(.sizeThatFits)
        .padding()
    }
}

