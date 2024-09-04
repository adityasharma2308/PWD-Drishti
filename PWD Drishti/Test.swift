import Foundation
import SwiftUI

struct Test: View {
    @State private var properties: [Property] = []
    
    var body: some View {
        VStack {
            Button(action: fetchProperties) {
                Text("Fetch Properties")
            }
            List(properties) { property in
                VStack(alignment: .leading) {
                    Text(property.name)
                        .font(.headline)
                    Text(property.location)
                        .font(.subheadline)
                }
            }
        }
    }
    
    func fetchProperties() {
        let userId = "52119180"
        let apiKey = "fac907f1c51c1ea00855301376f44102e432df119264bd568ce028e723fec8e80a1257bcd2e2b49411568a92eb47397edce663859191395e64d19f2719fc758d"
        
        APII.fetchProperties(user_id: userId, apiKey: apiKey) { result in
            switch result {
            case .success(let properties):
                self.properties = properties
            case .failure(let error):
                print("Error fetching properties: \(error.localizedDescription)")
            }
        }
    }
}


struct Property: Identifiable, Codable {
    let id: String
    let name: String
    let location: String
    // Add other properties as needed
    
    enum CodingKeys: String, CodingKey {
        case id = "property_id"
        case name = "property_name"
        case location = "property_location"
        // Map other JSON keys to properties
    }
}

/*class APII {
    static func fetchProperties(user_id: String, apiKey: String, completion: @escaping (Result<[Property], Error>) -> Void) {
        guard let url = URL(string: "https://pwddrishti.cgstate.gov.in/api/properties_list") else {
            completion(.failure(APIErrorr.invalidURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(apiKey, forHTTPHeaderField: "x-api-key")
        
        let parameters: [String: Any] = ["user_id": user_id]
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
        } catch {
            completion(.failure(APIError.encodingError))
            return
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                completion(.failure(APIErrorr.invalidResponse))
                return
            }
            
            guard let data = data else {
                completion(.failure(APIErrorr.invalidResponse))
                return
            }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
                print(json)
                
                // Assuming the response is an array of properties
                let properties = try JSONDecoder().decode([Property].self, from: data)
                completion(.success(properties))
            } catch {
                completion(.failure(APIErrorr.decodingError))
            }
        }.resume()
    }
}*/

class APII {
    static func fetchProperties(user_id: String, apiKey: String, completion: @escaping (Result<[Property], Error>) -> Void) {
        guard let url = URL(string: "https://pwddrishti.cgstate.gov.in/api/properties_list") else {
            completion(.failure(APIError.invalidURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(apiKey, forHTTPHeaderField: "x-api-key")
        
        let parameters: [String: Any] = ["user_id": user_id]
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
        } catch {
            completion(.failure(APIError.encodingError))
            return
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                completion(.failure(APIError.invalidResponse))
                return
            }
            
            guard let data = data else {
                completion(.failure(APIError.invalidResponse))
                return
            }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
                print(json)  // Print the raw JSON response
                
                // Assuming the response is an array of properties
                //let properties = try JSONDecoder().decode([Property].self, from: data)
                //completion(.success(properties))
            } catch {
                completion(.failure(APIErrorr.decodingError))
            }
        }.resume()
    }
}

enum APIErrorr: Error, LocalizedError {
    case invalidURL
    case encodingError
    case invalidResponse
    case decodingError
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "The URL is invalid."
        case .encodingError:
            return "There was an error encoding the data."
        case .invalidResponse:
            return "The response from the server was invalid."
        case .decodingError:
            return "There was an error decoding the data."
        }
    }
}

#Preview {
    Test()
}

