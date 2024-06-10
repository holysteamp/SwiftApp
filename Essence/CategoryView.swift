import SwiftUI

struct CategoryView: View {
@EnvironmentObject var favoritesViewModel: FavoritesViewModel
    
    let category: ProductCategory
    let products: [Product]
    
    let columns: [GridItem] = Array(repeating: GridItem(.flexible(), spacing: 10), count: 2)
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns) {
                ForEach(products) { product in
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
                }
                .frame(width: 1, height: 310)
            }
        }
        .navigationBarTitle(category.rawValue)
    }
}

struct MakeupView: View {
    let makeupProducts: [Product]
    var body: some View {
        CategoryView(category: .makeup, products: makeupProducts)
    }
}

struct FacecareView: View {
    let facecareProducts: [Product]
    var body: some View {
        CategoryView(category: .facecare, products: facecareProducts)
    }
}

struct HairView: View {
    let hairProducts: [Product]
    var body: some View {
        CategoryView(category: .hair, products: hairProducts)
    }
}

struct PerfumeView: View {
    let perfumeProducts: [Product]
    var body: some View {
        CategoryView(category: .perfume, products: perfumeProducts)
    }
}

struct FormenView: View {
    let formenProducts: [Product]
    var body: some View {
        CategoryView(category: .formen, products: formenProducts)
    }
}

struct ForkidsView: View {
    let forkidsProducts: [Product]
    var body: some View {
        CategoryView(category: .forkids, products: forkidsProducts)
    }
}

struct AccessoriesView: View {
    let accessoriesProducts: [Product]
    var body: some View {
        CategoryView(category: .accessories, products: accessoriesProducts)
    }
}

protocol FavoritesObserver: AnyObject {
    func favoritesDidChange()
}

struct CategoryView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CategoryView(category: .makeup, products: Product.makeupProducts)
            CategoryView(category: .facecare, products: Product.facecareProducts)
            CategoryView(category: .hair, products: Product.hairProducts)
            CategoryView(category: .perfume, products: Product.perfumeProducts)
            CategoryView(category: .formen, products: Product.formenProducts)
            CategoryView(category: .forkids, products: Product.forkidsProducts)
            CategoryView(category: .accessories, products: Product.accessoriesProducts)
        }
        .environmentObject(FavoritesViewModel())
    }
}
