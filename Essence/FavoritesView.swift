import SwiftUI

class FavoritesViewModel: ObservableObject {
    @Published var favorites: [Product] = []

    func addToFavorites(_ product: Product) {
        if !favorites.contains(product) {
            favorites.append(product)
        }
    }

    func removeFromFavorites(_ product: Product) {
        if let index = favorites.firstIndex(of: product) {
            favorites.remove(at: index)
        }
    }
    
    func isFavorite(product: Product) -> Bool {
        return favorites.contains(product)
    }
}

struct FavoritesView: View {
    @EnvironmentObject var favoritesViewModel: FavoritesViewModel
    
    let columns: [GridItem] = Array(repeating: GridItem(.flexible(), spacing: 10), count: 2)
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: columns) {
                    ForEach(favoritesViewModel.favorites) { product in
                        NavigationLink(destination: ProductDetailView(product: product)) {
                            VStack(alignment: .leading) {
                                Image(product.imageName)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 150, height: 200)
                                
                                Spacer ()
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
                        .frame(width: 1, height: 310)
                    }
                }
            }
            .navigationBarTitle("Избранное")
        }
    }
}

struct FavoritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesView()
            .environmentObject(FavoritesViewModel())
    }
}

