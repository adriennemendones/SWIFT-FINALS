import SwiftUI

struct WalletView: View {
    @State private var phoneNumber: String = ""
    @AppStorage("currentBalance") private var currentBalance: Double = 0.0 // Persist balance
    @State private var showAlert: Bool = false
    @State private var alertMessage: String = ""
    @State private var showResetConfirmation: Bool = false // Tracks reset confirmation dialog

    // Saved payment methods
    @AppStorage("savedPaymentMethods") private var savedPaymentMethodsData: Data = Data() // Persist saved numbers
    @State private var savedPaymentMethods: [String] = []

    // State for custom amount entry and confirmation
    @AppStorage("topUpAmount") private var topUpAmount: String = "" // Persist top-up amount
    @State private var showConfirmationDialog = false

    // Transaction history
    @AppStorage("transactionsData") private var transactionsData: Data = Data() // Persist transactions
    @State private var transactions: [Transaction] = []

    var body: some View {
        NavigationView {
            VStack {
                // Header with centered title
                HStack {
                    Spacer()
                    Text("Wallet")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                    Spacer()
                }
                .padding([.top, .leading, .trailing], 16)

                Divider().background(Color.gray)

                Spacer().frame(height: 30) // Space between title and balance display

                // Balance Section
                VStack {
                    Text("Current Balance")
                        .font(.subheadline)
                        .foregroundColor(.gray)

                    Text("₱ \(currentBalance, specifier: "%.2f")")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.green)
                        .padding(.top, 5)
                }
                .padding(.bottom, 10)

                Divider().background(Color.gray).padding(.horizontal, 40)

                Spacer().frame(height: 30)

                // Phone Number Input Section
                VStack {
                    Text("Enter GCash Phone Number")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                        .padding(.bottom, 5)

                    HStack {
                        Text("+63")
                            .foregroundColor(.gray)
                            .padding(.leading, 10)

                        TextField("Enter 10-digit number", text: $phoneNumber)
                            .keyboardType(.numberPad)
                            .onChange(of: phoneNumber) { newValue in
                                phoneNumber = String(newValue.filter { "0123456789".contains($0) }.prefix(10))
                            }
                            .padding()
                    }
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .padding(.horizontal, 40)
                }
                .padding(.bottom, 20)

                // Saved Numbers Section
                if !savedPaymentMethods.isEmpty {
                    VStack(alignment: .leading) {
                        Text("Saved Payment Methods")
                            .font(.headline)
                            .padding(.horizontal, 40)

                        ForEach(savedPaymentMethods, id: \.self) { method in
                            HStack {
                                Image(systemName: "phone.fill")
                                    .foregroundColor(.gray)
                                Text("+63 \(method)")
                                    .font(.body)
                                    .foregroundColor(.black)
                                    .onTapGesture {
                                        phoneNumber = method // Reuse the saved number
                                    }

                                Spacer()

                                Button(action: {
                                    removePaymentMethod(method)
                                }) {
                                    Image(systemName: "trash")
                                        .foregroundColor(.red)
                                }
                            }
                            .padding(.horizontal, 40)
                            .padding(.vertical, 5)
                        }
                    }
                }

                Spacer().frame(height: 20)

                // Custom Amount Entry Section
                VStack {
                    Text("Enter Top-Up Amount")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                        .padding(.bottom, 5)

                    TextField("₱0.00", text: $topUpAmount)
                        .keyboardType(.decimalPad)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                        .padding(.horizontal, 40)
                        .onChange(of: topUpAmount) { newValue in
                            topUpAmount = newValue.filter { "0123456789.".contains($0) }
                            if topUpAmount.filter({ $0 == "." }).count > 1 {
                                topUpAmount.removeLast()
                            }
                        }
                }
                .padding(.bottom, 20)

                // Top-Up Button
                Button(action: {
                    if isValidPhoneNumber() && isValidTopUpAmount() {
                        showConfirmationDialog = true
                    } else {
                        showAlert = true
                        alertMessage = isValidPhoneNumber() ? "Please enter a valid top-up amount." : "Please enter a valid 10-digit number after +63."
                    }
                }) {
                    HStack {
                        Image(systemName: "plus.circle.fill")
                            .font(.title2)
                        Text("Top-Up")
                            .fontWeight(.bold)
                            .font(.title2)
                    }
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.green)
                    .cornerRadius(10)
                    .padding(.horizontal, 40)
                }
                .alert(isPresented: $showAlert) {
                    Alert(title: Text("Invalid Input"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
                }
                .alert(isPresented: $showConfirmationDialog) {
                    Alert(
                        title: Text("Confirm Top-Up"),
                        message: Text("Are you sure you want to top up ₱\(topUpAmount)?"),
                        primaryButton: .default(Text("Confirm")) {
                            topUpBalance()
                            savePaymentMethod()
                        },
                        secondaryButton: .cancel()
                    )
                }

                // Reset Button
                Button(action: {
                    showResetConfirmation = true
                }) {
                    Text("Reset Wallet")
                        .fontWeight(.bold)
                        .foregroundColor(.red)
                        .padding()
                }
                .alert(isPresented: $showResetConfirmation) {
                    Alert(
                        title: Text("Are you sure you want to reset wallet?"),
                        message: Text("This will clear your balance and transaction history."),
                        primaryButton: .destructive(Text("Reset")) {
                            resetWallet()
                        },
                        secondaryButton: .cancel()
                    )
                }
                .padding(.top, 10)

                // Navigation Button to Transaction History Page
                NavigationLink(destination: TransactionHistoryView(transactions: transactions)) {
                    Text("View Transaction History")
                        .fontWeight(.bold)
                        .foregroundColor(.blue)

                }

                Spacer()
            }
            .navigationBarHidden(true)
            .onAppear {
                loadSavedData() // Load the saved top-up amount, saved numbers, and transactions when the view appears
            }
        }
    }

    // MARK: - Persistence Methods

    private func saveTransactions() {
        do {
            let data = try JSONEncoder().encode(transactions)
            transactionsData = data
        } catch {
            print("Failed to save transactions: \(error.localizedDescription)")
        }
    }

    private func loadSavedData() {
        do {
            savedPaymentMethods = try JSONDecoder().decode([String].self, from: savedPaymentMethodsData)
            transactions = try JSONDecoder().decode([Transaction].self, from: transactionsData)
        } catch {
            print("Failed to load saved data: \(error.localizedDescription)")
        }
    }

    private func savePaymentMethod() {
        if !savedPaymentMethods.contains(phoneNumber) {
            savedPaymentMethods.append(phoneNumber)
            do {
                let data = try JSONEncoder().encode(savedPaymentMethods)
                savedPaymentMethodsData = data
            } catch {
                print("Failed to save payment methods: \(error.localizedDescription)")
            }
        }
    }

    private func removePaymentMethod(_ method: String) {
        savedPaymentMethods.removeAll { $0 == method }
        do {
            let data = try JSONEncoder().encode(savedPaymentMethods)
            savedPaymentMethodsData = data
        } catch {
            print("Failed to remove payment method: \(error.localizedDescription)")
        }
    }

    // MARK: - Validation Methods

    private func isValidPhoneNumber() -> Bool {
        return phoneNumber.count == 10
    }

    private func isValidTopUpAmount() -> Bool {
        if let amount = Double(topUpAmount), amount > 0 {
            return true
        }
        return false
    }

    // MARK: - Top-Up Logic

    private func topUpBalance() {
        if let amount = Double(topUpAmount) {
            currentBalance += amount
            transactions.append(Transaction(amount: amount, date: Date()))
            saveTransactions()
            showAlert = true
            alertMessage = "Top-up successful! ₱\(amount) has been added to your balance."
            topUpAmount = ""
        }
    }

    // MARK: - Reset Logic

    private func resetWallet() {
        currentBalance = 0.0
        transactions.removeAll()
        saveTransactions()
        showAlert = true
        alertMessage = "Wallet has been reset."
    }
}

// MARK: - Preview

struct WalletView_Previews: PreviewProvider {
    static var previews: some View {
        WalletView()
    }
}
