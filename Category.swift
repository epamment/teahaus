import Foundation

struct Category: Codable, Identifiable
{
    let id: Int
    let name: String
}

class CategoryViewModel: ObservableObject{
    @Published var categories: [Category] = []
    func loadCategories() {
        guard let url = URL(string: "http://127.0.0.1:8000/api/category/") else {
            print("Category API endpoint is invalid")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("Basic ZXBhbW1lbnQ6UGlhbm9rZXkhMzIx", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                if let response = try? JSONDecoder().decode([Category].self, from: data) {
                    DispatchQueue.main.async {
                        self.categories = response
                    }
                    return
                }
            }
            print("Failed to fetch categories:", error?.localizedDescription ?? "Unknown error")
        }.resume()
    }
}
