import SwiftUI

struct TransactionHistoryView: View {
    let transactions: [Transaction] // The transactions passed from WalletView
    
    var body: some View {
        VStack {
            Text("Transaction History")
                .font(.title)
                .fontWeight(.bold)
                .padding(.top, 20)
            
            List(transactions.sorted(by: { $0.date > $1.date })) { transaction in
                HStack {
                    Text("Top-Up")
                        .font(.body)
                    
                    Spacer()
                    
                    Text("₱ \(transaction.amount, specifier: "%.2f")")
                        .font(.body)
                        .foregroundColor(.green)
                    
                    Spacer()
                    
                    Text("\(transaction.date, formatter: transactionDateFormatter)")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
                .padding(.vertical, 5)
            }
            .listStyle(PlainListStyle()) // Style the list
        }
        .padding(.horizontal, 20)
        .navigationBarTitle("Transactions", displayMode: .inline)
    }
}

// Date formatter for displaying the date in the transaction history
let transactionDateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .short
    return formatter
}()

//
