import SwiftUI
import URLImage

struct ContentView: View {
    @State var categories = [Category]()
    @State var teas = [Tea]()
    @State var selectedCategory: Category?
    @State var selectedTea: Tea?
    
    
    var body: some View {
        NavigationView {
            VStack {
                if selectedCategory == nil {
                    CategoryList(categories: categories)
                        .onAppear(perform: loadCategories)
                } else if let selectedCategory = selectedCategory {
                    let filteredTeas = teas.filter { $0.category == selectedCategory.id }
                    TeaListView(category: selectedCategory, teas: filteredTeas)
                }
                if let selectedTea = selectedTea {
                    TeaDetailView(tea: selectedTea)
                }
            }
            .navigationBarTitle(selectedCategory == nil ? "Categories" : selectedCategory!.name)
        }
    }
}

struct CategoryList: View {
    let categories: [Category]
    
    var body: some View {
        VStack{
            List(categories) { category in
                NavigationLink(destination: TeaListView(category: category, teas: [])) {
                    Text(category.name)
                      
                }
            }
        }
    }
}

struct TeaListView: View {
    let category: Category
    @State var teas: [Tea] = []
    
    var body: some View {
        VStack {
            ScrollView {
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 10) {
                    ForEach(teas) { tea in
                        NavigationLink(destination: TeaDetailView(tea: tea)) {
                            RoundedRectangle(cornerRadius: 10)
                                .frame(width: 185, height: 230)
                                .foregroundColor(.white)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .inset(by: 1.5)
                                        .stroke(Color.black, lineWidth: 2.5)
                                )
                                .overlay(
                                    VStack {
                                        URLImage(URL(string: tea.tea_pic!)!) { image in
                                        image
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .cornerRadius(10)
                                        }
                                        .frame(maxWidth: .infinity, maxHeight: 150)
                                        .padding(.top, 10)
                                        Text(tea.name)
                                            .foregroundColor(.black)
                                            .font(.headline)
                                            .lineSpacing(0.3)
                                            .padding(20)
                                    }
                                )
                        }
                    }
                }
            }
            .onAppear(perform: loadTeas)
        }

        .navigationBarTitle(category.name)
        .font(Font.custom("Archivo", size: 20).weight(.semibold))
        .lineSpacing(16.40)
        .foregroundColor(.black);
    }
}

struct TeaDetailView: View {
    @State var tea: Tea

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text(tea.name)
                    .font(.title)
                    .bold()

                Text(tea.description)
                    .font(.body)

                Toggle(isOn: $tea.hasTried) {
                    Text("Has Tried")
                        .font(.headline)
                }

                Text("Tasting Notes:")
                    .font(.headline)
                Text(tea.tasting_notes)
                    .font(.body)
                TextField("Enter tasting notes", text: $tea.tasting_notes)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
            }.onAppear(perform: loadTeaDetail)
            .padding()
        }
        .navigationBarTitle(String(tea.code))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
