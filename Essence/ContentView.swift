import SwiftUI

struct ContentView: View {
    @State private var selectedTab = 1
    @StateObject private var favoritesViewModel = FavoritesViewModel()
    @StateObject private var cartViewModel = CartViewModel()
    var body: some View {
            TabView(selection: $selectedTab) {
                SearchCategoriesView()
                    .tabItem {
                        if selectedTab == 1 {
                            Image("Search")
                        } else {
                            Image("Search")
                        }
                        Text("")
                    }
                    .tag(1)
                
                FavoritesView()
                    .tabItem {
                        if selectedTab == 2 {
                            Image("Heartdark")
                        } else {
                            Image("Heart")
                        }
                        Text("")
                    }
                    .tag(2)
                    .environmentObject(favoritesViewModel)
                
                HomeView(category: .home, products: Product.homeProducts)
                    .tabItem {
                        if selectedTab == 3 {
                            Image("Clouddark")
                        } else {
                            Image("Cloud")
                        }
                        Text("")
                    }
                    .tag(3)
                
                CartView()
                    .tabItem {
                        if selectedTab == 5 {
                            Image("Cartdark")
                        } else {
                            Image("Cart")
                        }
                        Text("")
                    }
                    .tag(4)
            }
            .background(Color.white)
            .shadow(color: Color.black.opacity(0.15), radius: 8, x: 2, y: 6)
            .environmentObject(favoritesViewModel)
            .environmentObject(cartViewModel)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
