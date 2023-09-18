import Foundation

struct Tea: Decodable, Identifiable {
    let id: Int
    let code: Int
    let name: String
    let description: String
    var hasTried: Bool
    var wantToTry: Bool
    var tasting_notes: String
    let category: Int
    let tags: [Int]?
    let tea_pic: String?
}

class TeaListViewModel: ObservableObject {
    @Published var teas: [Tea] = []
    
    init(category: Category) {
        loadTeas(for: category)
    }
    
    func loadTeas(for category: Category) {
        guard let url = URL(string: "http://127.0.0.1:8000/api/category/\(category.id)/tea/") else {
            print("Tea API endpoint is invalid")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("Basic ZXBhbW1lbnQ6UGlhbm9rZXkhMzIx", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                if let response = try? JSONDecoder().decode([Tea].self, from: data) {
                    DispatchQueue.main.async {
                        self.teas = response
                    }
                    return
                }
            }
            print("Failed to fetch teas:", error?.localizedDescription ?? "Unknown error")
        }.resume()
    }
}

class TeaDetailViewModel: ObservableObject {
    @Published var tea: Tea
    
    init(tea: Tea) {
        self.tea = tea
    }
    
    func loadTeaDetail() {
        guard let url = URL(string: "http://127.0.0.1:8000/api/tea/\(tea.id)/") else {
            print("Tea API endpoint is invalid")
            return
        }
        print(url)
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("Basic ZXBhbW1lbnQ6UGlhbm9rZXkhMzIx", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                if let response = try? JSONDecoder().decode(Tea.self, from: data) {
                    DispatchQueue.main.async {
                        self.tea = response
                    }
                    return
                }
            }
            print("Failed to fetch tea:", error?.localizedDescription ?? "Unknown error")
        }.resume()
    }
}

