import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            HomeView() // Use existing HomeView
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Dashboard")
                }

            WalletView() // Main WalletView content as defined
                .tabItem {
                    Image(systemName: "creditcard.fill")
                    Text("Wallet")
                }
            
            DonationsView() // Use existing DonationsView
                .tabItem {
                    Image(systemName: "heart.fill")
                    Text("Donations")
                }
            
            SettingsView() // Use existing SettingsView
                .tabItem {
                    Image(systemName: "gearshape.fill")
                    Text("Settings")
                }
        }
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}

//
