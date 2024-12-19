import SwiftUI

struct Transaction: Identifiable, Codable {
    let id = UUID()
    let amount: Double
    let date: Date
}
