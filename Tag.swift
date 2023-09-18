import Foundation

struct Tag: Codable, Identifiable
{
    let id: Int
    let name: String
}


class TagViewModel: ObservableObject {
    @Published var tag: Tag
    
    init(tag: Tag) {
        self.tag = tag
    }
    
    func loadTagDetail() {
        guard let url = URL(string: "http://127.0.0.1:8000/api/tag/\(tag.id)/") else {
            print("Tag API endpoint is invalid")
            return
        }
        print(url)
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("Basic ZXBhbW1lbnQ6UGlhbm9rZXkhMzIx", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                if let response = try? JSONDecoder().decode(Tag.self, from: data) {
                    DispatchQueue.main.async {
                        self.tag = response
                    }
                    return
                }
            }
            print("Failed to fetch tag:", error?.localizedDescription ?? "Unknown error")
        }.resume()
    }
}
