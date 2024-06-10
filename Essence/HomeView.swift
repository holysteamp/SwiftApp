import SwiftUI
import AVKit

struct HomeView: View {
    @EnvironmentObject var favoritesViewModel: FavoritesViewModel
    
    let columns: [GridItem] = Array(repeating: GridItem(.flexible(), spacing: 5), count: 2)
    
    let category: ProductCategory
    let products: [Product]
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    BannerView()
                        .padding(.top, 20)
                    Spacer()
                        .frame(height: 35)
                    
                    VStack(alignment: .leading) {
                        Text("Лучшие предложения")
                            .font(.title)
                            .fontWeight(.medium)
                            .padding(.bottom, -1)
                            .padding(.leading)
                        
                        LazyVGrid(columns: columns) {
                            ForEach(products) { product in
                                NavigationLink(destination: ProductDetailView(product: product)) {
                                    VStack(alignment: .leading) {
                                        Image(product.imageName)
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: 150, height: 200)
                                        
                                        Spacer()
                                            .frame(height: 20)
                                        
                                        HStack {
                                            Text(product.name)
                                                .font(.system(size: 17))
                                                .fontWeight(.semibold)
                                                .foregroundColor(Color.black)
                                        }
                                        .frame(height: 20)
                                        
                                        HStack {
                                            Text("\(product.price) ₸")
                                                .font(.system(size: 18))
                                                .fontWeight(.semibold)
                                                .foregroundColor(Color.gray)
                                            
                                            Button(action: {
                                                if favoritesViewModel.isFavorite(product: product) {
                                                    favoritesViewModel.removeFromFavorites(product)
                                                } else {
                                                    favoritesViewModel.addToFavorites(product)
                                                }
                                            }) {
                                                Image(favoritesViewModel.isFavorite(product: product) ? "Heartdark" : "Heart")
                                                    .resizable()
                                                    .frame(width: 24, height: 24)
                                                    .padding(.leading, 40)
                                            }
                                        }
                                    }
                                    .padding()
                                    .cornerRadius(1)
                                }
                                .buttonStyle(PlainButtonStyle())
                            }
                            .frame(width: 1, height: 310)
                        }
                    }
                }
                .navigationBarTitle("Главная")
            }
        }
    }
}

struct BannerView: View {
    var body: some View {
        TabView {
            ForEach(0..<3) { index in
                Image("banner\(index)")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .clipped()
            }
        }
        .frame(height: 200)
        .tabViewStyle(PageTabViewStyle())
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(category: .home, products: Product.homeProducts)
            .environmentObject(FavoritesViewModel())
    }
}
