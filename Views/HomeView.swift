import SwiftUI
import MapKit
import FirebaseAuth
import FirebaseFirestore

// Enum for tab selection
enum Tab {
    case home, wallet, settings // Removed donations
}

// Enum to track selected view for navigation from the side menu
enum SelectedView {
    case home, profile, feedback, about
}

// Municipality model for map annotations
struct Municipality: Identifiable {
    let id = UUID()
    let name: String
    let coordinate: CLLocationCoordinate2D
}

struct HomeView: View {
    @AppStorage("uid") var userID: String = ""
    @State private var showMenu = false // Tracks the visibility of the side menu
    @State private var selectedTab: Tab = .home // Tracks the selected tab
    @State private var selectedView: SelectedView = .home // Tracks selected view for side menu navigation

    // Map region centered on Lucena, Quezon
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 13.9374, longitude: 121.6172), // Lucena City
        span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05) // Zoom level
    )

    let municipality = Municipality(
        name: "Lucena City",
        coordinate: CLLocationCoordinate2D(latitude: 13.9374, longitude: 121.6172)
    )

    var body: some View {
        NavigationView {
            ZStack(alignment: .leading) {
                mainTabView

                // Side Menu Overlay
                if showMenu {
                    Color.black.opacity(0.5)
                        .ignoresSafeArea()
                        .onTapGesture {
                            withAnimation {
                                showMenu = false
                            }
                        }

                    SideMenuView(isShowing: $showMenu, selectedView: $selectedView)
                        .frame(width: 250)
                        .background(Color.white)
                        .offset(x: showMenu ? 0 : -250)
                        .animation(.easeInOut, value: showMenu)
                        .zIndex(1)
                }
            }
        }
    }

    // Main TabView with Home, Wallet, and Settings tabs
    private var mainTabView: some View {
        TabView(selection: $selectedTab) {
            ScrollView {
                VStack(spacing: 0) {
                    headerView
                    mapCardView // Enlarged map view
                    campaignCategories
                    Spacer()
                }
            }
            .tag(Tab.home)
            .tabItem {
                Image(systemName: "house.fill")
                Text("Home")
            }

            WalletView()
                .tag(Tab.wallet)
                .tabItem {
                    Image(systemName: "creditcard.fill")
                    Text("Wallet")
                }

            SettingsView()
                .tag(Tab.settings)
                .tabItem {
                    Image(systemName: "gearshape.fill")
                    Text("Settings")
                }
        }
        .accentColor(Color.green)
        .animation(.easeInOut, value: selectedTab)
    }

    // Header View
    private var headerView: some View {
        VStack(spacing: 0) {
            HStack {
                Button(action: {
                    withAnimation {
                        showMenu.toggle()
                    }
                }) {
                    Image(systemName: "line.horizontal.3")
                        .font(.title)
                        .foregroundColor(.green)
                        .padding()
                }

                Spacer()

                Text("Dashboard")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.black)

                Spacer()

                Image("ecologo") // Placeholder for your logo
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40, height: 40)
                    .padding(.trailing, 16)
            }
            .padding([.top, .leading, .trailing], 16)

            Divider()
                .background(Color.gray)
        }
    }

    // Enlarged Map Card View
    private var mapCardView: some View {
        VStack {
            Text("Lucena City Map")
                .font(.headline)
                .padding(.top, 5)

            ZStack(alignment: .topTrailing) {
                Map(coordinateRegion: $region, annotationItems: [municipality]) { location in
                    MapAnnotation(coordinate: location.coordinate) {
                        VStack {
                            Image(systemName: "mappin.circle.fill")
                                .foregroundColor(.red)
                                .font(.title)
                            Text(location.name)
                                .font(.caption)
                                .foregroundColor(.black)
                        }
                    }
                }
                .frame(height: 400) // Increased height for the map view
                .cornerRadius(15)
                .shadow(radius: 5)
                .padding()

                VStack(spacing: 10) {
                    Button(action: zoomIn) {
                        Image(systemName: "plus.magnifyingglass")
                            .foregroundColor(.white)
                            .frame(width: 40, height: 40)
                            .background(Color.green)
                            .clipShape(Circle())
                    }

                    Button(action: zoomOut) {
                        Image(systemName: "minus.magnifyingglass")
                            .foregroundColor(.white)
                            .frame(width: 40, height: 40)
                            .background(Color.green)
                            .clipShape(Circle())
                    }
                }
                .padding(.trailing, 15)
                .padding(.top, 10)
            }
        }
    }

    private func zoomIn() {
        region.span.latitudeDelta /= 2
        region.span.longitudeDelta /= 2
    }

    private func zoomOut() {
        region.span.latitudeDelta *= 2
        region.span.longitudeDelta *= 2
    }

    private var campaignCategories: some View {
        VStack(alignment: .leading) {
            Text("Campaign Categories")
                .font(.headline)
                .padding(.leading)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 20) {
                    ForEach(CampaignCategory.allCases, id: \.self) { category in
                        NavigationLink(destination: CategoryDetailView(category: category)) {
                            VStack {
                                Image(systemName: category.iconName)
                                    .font(.largeTitle)
                                    .foregroundColor(.white)
                                    .padding()
                                    .background(Color.green)
                                    .clipShape(Circle())
                                Text(category.title)
                                    .font(.caption)
                                    .foregroundColor(.black)
                            }
                        }
                    }
                }
                .padding(.horizontal)
            }
        }
        .padding(.top)
    }
}

// Preview
struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
