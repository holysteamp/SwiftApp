import SwiftUI

struct ProductDetailView: View {
    @EnvironmentObject var cartViewModel: CartViewModel
    let product: Product
    
    var body: some View {
        VStack {
            ScrollView {
                VStack(spacing: 10) {
                    Image(product.imageName)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(height: 280)
                        .clipped()
                
                    VStack(alignment: .leading, spacing: 20) {
                        Text("\(product.price) ₸")
                            .font(.title)
                            .fontWeight(.bold)
                        
                        Text("Описание")
                            .font(.headline)
                            .fontWeight(.medium)
                        
                        Text(product.name)
                            .font(.title3)
                            .fontWeight(.semibold)
                        
                        Text(product.description)
                            .padding(.trailing)
                            .font(.body)
                    }
                    .padding()
                }
            }
            
            Spacer()
            
            HStack {
                Spacer()
                Button(action: {
                    cartViewModel.addProductToCart(product)
                }) {
                    Text("Добавить в корзину")
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.black)
                        .cornerRadius(10)
                }
                .padding()
            }
            .background(Color.white.shadow(radius: 2))
        }
        .navigationBarTitle(product.name, displayMode: .large)
    }
}

struct ProductDetailView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ForEach(Product.allProducts) { product in
                NavigationView {
                    ProductDetailView(product: product)
                        .environmentObject(CartViewModel())
                }
            }
        }
    }
}

