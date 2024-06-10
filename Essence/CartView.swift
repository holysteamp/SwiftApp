import SwiftUI

class CartViewModel: ObservableObject {
    @Published var productsInCart: [Product] = []
    
    func addProductToCart(_ product: Product) {
        productsInCart.append(product)
    }
    
    var totalPrice: Int {
        return productsInCart.reduce(0) { $0 + $1.price }
    }
}

struct CartView: View {
    @EnvironmentObject var cartViewModel: CartViewModel
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(cartViewModel.productsInCart) { product in
                        HStack {
                            Image(product.imageName)
                                .resizable()
                                .frame(width: 50, height: 50)
                                .cornerRadius(8)
                            VStack(alignment: .leading) {
                                Text(product.name)
                                    .font(.headline)
                                Text("\(product.price) ₸")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                        }
                    }
                }
                Text("Итоговая сумма: \(cartViewModel.totalPrice) ₸")
                    .font(.title)
                    .padding()
            }
            .navigationBarTitle("Корзина")
        }
    }
}

struct CartView_Previews: PreviewProvider {
    static var previews: some View {
        CartView()
            .environmentObject(CartViewModel())
    }
}


