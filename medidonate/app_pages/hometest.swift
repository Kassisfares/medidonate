import Foundation
import SwiftUI

struct ApiResponse1: Decodable {
    let data: [PostData1]
    let meta: Meta
}

struct PostData1: Decodable {
    let id: Int
    var attributes: PostAttributes1
}

struct PostAttributes1: Decodable {
    var description: String
    let createdAt: Date
    let updatedAt: Date
    let publishedAt: Date
    let message: String?
    let usersPermissionsUser: User
    let photos: Photos?

    enum CodingKeys: String, CodingKey {
        case description, createdAt, updatedAt, publishedAt, message, photos
        case usersPermissionsUser = "users_permissions_user"
    }
}

struct User: Decodable {
    let id: Int
    let username: String
    let email: String
    let provider: String
    let confirmed: Bool
    let blocked: Bool
    let createdAt: Date
    let updatedAt: Date
    let phone: String?
}

struct Photos: Decodable {
    let data: [PhotoData]?
}

struct PhotoData: Decodable {
    // Define photo data structure
}

struct Meta: Decodable {
    let pagination: Pagination
}

struct Pagination: Decodable {
    let page: Int
    let pageSize: Int
    let pageCount: Int
    let total: Int
}


extension DateFormatter {
    static let iso8601Full1: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter
    }()
    
    static let iso8601WithoutMilliseconds1: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter
    }()

    static let iso8601DateOnly1: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter
    }()
}

extension JSONDecoder.DateDecodingStrategy {
    static var flexibleISO86011: JSONDecoder.DateDecodingStrategy {
        .custom { decoder -> Date in
            let container = try decoder.singleValueContainer()
            if container.decodeNil() {
                // Return a default date in case of nil because we can't return nil from a non-optional return type function in this context.
                // This default date can be used to identify unset dates later in your application logic.
                return Date.distantPast
            }
            let dateStr = try container.decode(String.self)
            
            let formatters = [
                DateFormatter.iso8601Full,
                DateFormatter.iso8601WithoutMilliseconds,
                DateFormatter.iso8601DateOnly
            ]
            
            for formatter in formatters {
                if let date = formatter.date(from: dateStr) {
                    return date
                }
            }
            
            // Throw decoding error if no formats match
            throw DecodingError.dataCorruptedError(in: container, debugDescription: "Cannot decode date string \(dateStr)")
        }
    }
}




//// Example usage
//let originalDateString = "2024-05-12T22:47:27.912Z"
//let newDateString = convertDate(from: originalDateString, fromFormat: "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'", toFormat: "yyyy-MM-dd")
//
////print(newDateString ?? "Invalid date")  // Output will be "2024-05-12" if successful


class DataFetcher: ObservableObject {
    @Published var posts = [PostData1]()
    @Published var isErrorPresented = false
    var errorMessage = ""

    class func fetchPosts(for fetcher: DataFetcher, completion: @escaping ([PostData1]?, Error?) -> Void) {
        guard let url = URL(string: "http://localhost:1337/api/post/myposts") else {
            completion(nil, NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"]))
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("Bearer YOUR_ACCESS_TOKEN", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                if let error = error {
                    fetcher.isErrorPresented = true
                    fetcher.errorMessage = "Network error: \(error.localizedDescription)"
                    completion(nil, error)
                    return
                }
                guard let data = data else {
                    fetcher.isErrorPresented = true
                    fetcher.errorMessage = "No data received"
                    completion(nil, NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "No data received"]))
                    return
                }
                do {
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .flexibleISO86011
                    let posts = try decoder.decode([PostData1].self, from: data)
                    completion(posts, nil)
                } catch {
                    fetcher.isErrorPresented = true
                    fetcher.errorMessage = "Failed to decode JSON: \(error.localizedDescription)"
                    completion(nil, error)
                }
            }
        }.resume()
    }
}

struct hometest: View {
    @ObservedObject var dataFetcher = DataFetcher()

    var body: some View {
        NavigationView {
            List(dataFetcher.posts, id: \.id) { post in
                Text(post.attributes.description)
                Text("Posted by: \(post.attributes.usersPermissionsUser.username)")
                Text("Email: \(post.attributes.usersPermissionsUser.email)")
                Text("Date: \(post.attributes.createdAt, formatter: itemFormatter)")
            }
            .navigationTitle("Posts")
            .onAppear {
                DataFetcher.fetchPosts(for: dataFetcher) { fetchedPosts, error in
                    if let posts = fetchedPosts {
                        self.dataFetcher.posts = posts
                    } else {
                        self.dataFetcher.isErrorPresented = true
                    }
                }
            }
            .alert(isPresented: $dataFetcher.isErrorPresented) {
                Alert(title: Text("Error"), message: Text(dataFetcher.errorMessage), dismissButton: .default(Text("OK")))
            }
        }
    }

    private var itemFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .none
        return formatter
    }
}

#Preview {
    hometest()
}

