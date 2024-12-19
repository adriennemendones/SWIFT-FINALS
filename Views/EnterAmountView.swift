import SwiftUI

struct EnterAmountView: View {
    @State private var donationAmount: String = ""
    @State private var showAlert: Bool = false
    @State private var alertMessage: String = ""
    @State private var alertTitle: String = "Error"
    @State private var showConfirmationDialog: Bool = false
    
    @AppStorage("currentBalance") private var walletBalance: Double = 0.0

    var body: some View {
        VStack {
            Text("Enter Donation Amount")
                .font(.title)
                .fontWeight(.bold)
                .padding(.top, 40)

            TextField("₱0.00", text: $donationAmount)
                .keyboardType(.decimalPad)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(10)
                .padding(.horizontal, 40)
                .onChange(of: donationAmount) { newValue in
                    donationAmount = newValue.filter { "0123456789.".contains($0) }
                    if donationAmount.filter({ $0 == "." }).count > 1 {
                        donationAmount.removeLast()
                    }
                }

            Button(action: {
                validateAndShowConfirmation()
            }) {
                HStack {
                    Text("Proceed")
                        .font(.headline)
                        .foregroundColor(.white)
                    Image(systemName: "arrow.right")
                        .foregroundColor(.white)
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.green)
                .cornerRadius(10)
                .padding(.horizontal, 40)
                .padding(.top, 20)
            }
            .alert(isPresented: $showAlert) {
                Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("OK")))
            }
            .confirmationDialog(
                "Confirm Donation",
                isPresented: $showConfirmationDialog,
                titleVisibility: .visible
            ) {
                Button("Yes, Donate", role: .none) {
                    processDonation()
                }
                Button("Cancel", role: .cancel) {}
            }

            Text("Wallet Balance: ₱\(String(format: "%.2f", walletBalance))")
                .font(.footnote)
                .foregroundColor(.gray)
                .padding(.top, 10)

            Spacer()
        }
        .navigationBarTitle("Enter Amount", displayMode: .inline)
    }

    // MARK: - Validation and Confirmation

    private func validateAndShowConfirmation() {
        if let donation = Double(donationAmount), donation > 0 {
            if donation <= walletBalance {
                showConfirmationDialog = true
            } else {
                showAlert = true
                alertTitle = "Error"
                alertMessage = "Insufficient wallet balance. Your current balance is ₱\(String(format: "%.2f", walletBalance))."
            }
        } else {
            showAlert = true
            alertTitle = "Error"
            alertMessage = "Please enter a valid donation amount."
        }
    }

    // MARK: - Process Donation

    private func processDonation() {
        if let donation = Double(donationAmount), donation > 0 {
            if donation <= walletBalance {
                walletBalance -= donation // Deduct the donation amount from wallet balance
                donationAmount = "" // Clear the donation amount field
                showAlert = true
                alertTitle = "Success"
                alertMessage = "Donation successful! ₱\(String(format: "%.2f", donation)) has been deducted from your wallet."
            } else {
                showAlert = true
                alertTitle = "Error"
                alertMessage = "Insufficient wallet balance. Your current balance is ₱\(String(format: "%.2f", walletBalance))."
            }
        } else {
            showAlert = true
            alertTitle = "Error"
            alertMessage = "Please enter a valid donation amount."
        }
    }
}

// MARK: - Preview

struct EnterAmountView_Previews: PreviewProvider {
    static var previews: some View {
        EnterAmountView()
    }
}

//
