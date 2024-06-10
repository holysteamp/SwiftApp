import SwiftUI

struct SearchCategoriesView: View {
    @State private var searchText = ""
    
    let categories = [
        ("Макияж", AnyView(MakeupView(makeupProducts: Product.makeupProducts))),
        ("Уход", AnyView(FacecareView(facecareProducts: Product.facecareProducts))),
        ("Волосы", AnyView(HairView(hairProducts: Product.hairProducts))),
        ("Парфюмерия", AnyView(PerfumeView(perfumeProducts: Product.perfumeProducts))),
        ("Для мужчин", AnyView(FormenView(formenProducts: Product.formenProducts))),
        ("Детям", AnyView(ForkidsView(forkidsProducts: Product.forkidsProducts))),
        ("Аксессуары", AnyView(AccessoriesView(accessoriesProducts: Product.accessoriesProducts)))
    ]
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    Spacer()
                        .frame(height: 15)
                    
                    // Поле поиска
                    HStack {
                        TextField("Поиск", text: $searchText)
                            .padding(8)
                            .padding(.horizontal, 25)
                            .background(Color(.systemGray6))
                            .cornerRadius(20)
                            .padding(.horizontal, 10)
                            .overlay(
                                HStack {
                                    Image(systemName: "magnifyingglass")
                                        .foregroundColor(.gray)
                                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                        .padding(.leading)
                                    
                                    if !searchText.isEmpty {
                                        Button(action: {
                                            self.searchText = ""
                                        }) {
                                            Image(systemName: "multiply.circle.fill")
                                                .foregroundColor(.gray)
                                                .padding(.trailing, 25)
                                        }
                                    }
                                }
                            )
                            .padding(.horizontal, 17)
                    }
                    
                    Spacer()
                        .frame(height: 17)
                    
                    // Список категорий
                    VStack {
                        ForEach(categories, id: \.0) { category in
                            NavigationLink(destination: category.1) {
                                HStack {
                                    Text(category.0)
                                        .fontWeight(.semibold)
                                        .foregroundColor(.black)
                                        .font(.system(size: 25))
                                    Spacer()
                                    Image(systemName: "chevron.right")
                                        .foregroundColor(.gray)
                                }
                                .padding()
                            }
                            .padding(.bottom, 4.0)
                        }
                    }
                    .padding(.horizontal, 17)
                    Spacer()
                }
            }
            .navigationBarTitle("Поиск и категории")
        }
    }
}

struct SearchCategoriesView_Previews: PreviewProvider {
    static var previews: some View {
        SearchCategoriesView()
    }
}
