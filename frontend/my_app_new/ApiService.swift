import Foundation

class ApiService {
    func postRequest(description: String, color: String, completion: @escaping (String) -> Void) {
        let url = URL(string: "http://localhost:5001/generate_image")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        let json: [String: Any] = ["description": description, "color": color]
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        
        request.httpBody = jsonData
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let data = data {
                do {
                    if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: String],
                       let imageUrl = json["url"] {
                        DispatchQueue.main.async {
                            completion(imageUrl)
                        }
                    }
                } catch {
                    print("Error during JSON serialization: \(error.localizedDescription)")
                }
            }
        }.resume()
    }
}
