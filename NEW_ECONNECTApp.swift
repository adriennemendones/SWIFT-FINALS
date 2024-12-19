//
//  NEW_ECONNECTApp.swift


import SwiftUI
import FirebaseCore
import FirebaseFirestore

@main
struct NEW_ECONNECTApp: App {
    init() {
        FirebaseApp.configure()
        Firestore.firestore().settings.isPersistenceEnabled = true
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

//
