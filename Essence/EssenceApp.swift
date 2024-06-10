import SwiftUI

@main
struct EssenceApp: App {
    @StateObject private var cartViewModel = CartViewModel()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(cartViewModel)
        }
    }
}
