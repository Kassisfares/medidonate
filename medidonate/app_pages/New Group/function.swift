import SwiftUI
import Foundation

// Define a service to handle request fetching
struct RequestService {
    // Function to fetch requests
    static func fetchRequests(completion: @escaping ([Datum1]?) -> Void) {
        guard let userID = AuthService.userID ?? RegisterService.userID else {
            print("User ID is not available.")
            completion(nil)
            return
        }
        
        guard let authToken = AuthService.token else {
            print("Auth token is not available.")
            completion(nil)
            return
        }

        print("Logged-in User ID: \(userID)")

        let urlString = "http://localhost:1337/api/requests?populate[post][populate][users_permissions_user][populate]=*"
        
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            completion(nil)
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(authToken)", forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error fetching data: \(error)")
                completion(nil)
                return
            }
            
            guard let data = data else {
                print("No data returned")
                completion(nil)
                return
            }
            
            do {
                // Print the raw JSON response for debugging
                if let jsonString = String(data: data, encoding: .utf8) {
                    print("Raw JSON response: \(jsonString)")
                }

                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let responseData = try decoder.decode(MainData.self, from: data)
                
                // Filter the data based on the logged-in user's ID
                let filteredData = responseData.data?.filter { datum in
                    if let postUserID = datum.attributes?.post?.data?.attributes?.users_permissions_user?.data?.id {
                        print("Post User ID: \(postUserID)") // Debug print
                        return postUserID == userID
                    }
                    return false
                }
                
                print("Filtered Requests Count: \(filteredData?.count ?? 0)") // Debug print
                
                completion(filteredData)
            } catch {
                print("Error decoding JSON: \(error)")
                completion(nil)
            }
        }
        
        task.resume()
    }
}

struct ContentView: View {
    @State private var requests: [Datum1] = []

    var body: some View {
        VStack {
            if requests.isEmpty {
                Text("No requests found for the logged-in user")
            } else {
                List(requests, id: \.id) { request in
                    if let id = request.id {
                        Text("Request ID: \(id)")
                    } else {
                        Text("Request ID: Unknown")
                    }
                }
            }
        }
        .onAppear {
            performRequestFetching()
        }
    }
    
    func performRequestFetching() {
        RequestService.fetchRequests { filteredRequests in
            guard let requests = filteredRequests else {
                print("No requests found for the logged-in user")
                return
            }
            
            // Update the UI on the main thread
            DispatchQueue.main.async {
                self.requests = requests
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
