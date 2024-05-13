//
//  HomeView.swift
//  medidonate
//
//  Created by fares kassis on 12/5/2024.
//

import SwiftUI

struct ApiResponse: Decodable {
    let data: [PostData]
}

struct PostData: Decodable {
    let id: Int
    let attributes: PostAttributes
}

struct PostAttributes: Decodable {
    let description: String
    let createdAt: Date
    let updatedAt: Date
    let publishedAt: Date
    let post_medicines: PostMedicineWrapper?
}

struct PostMedicineWrapper: Decodable {
    let data: [PostMedicineData]
}

struct PostMedicineData: Decodable {
    let id: Int
    let attributes: PostMedicineAttributes
}

struct PostMedicineAttributes: Decodable {
    let fabricationDate: Date?
    let expirationDate: Date?
    let quantity: Int
    let createdAt: Date
    let updatedAt: Date
    let medicines: MedicineWrapper
}

struct MedicineWrapper: Decodable {
    let data: MedicineData1
}

struct MedicineData1: Decodable {
    let id: Int
    let attributes: MedicineAttributes1
}

struct MedicineAttributes1: Decodable {
    let name: String
    let createdAt: Date
    let updatedAt: Date
    let publishedAt: Date
    let category: String
    let type: String
}

extension DateFormatter {
    static let iso8601Full: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter
    }()
    
    static let iso8601WithoutMilliseconds: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter
    }()

    static let iso8601DateOnly: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter
    }()
}

extension JSONDecoder.DateDecodingStrategy {
    static var flexibleISO8601: JSONDecoder.DateDecodingStrategy {
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




class PostViewModel: ObservableObject {
    @Published var posts = [PostAttributes]()

    func fetchPosts() {
        guard let url = URL(string: "http://localhost:1337/api/posts?populate=post_medicines.medicines") else {
            print("Invalid URL")
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NCwiaWF0IjoxNzE0NDMxNDE2LCJleHAiOjE3MTcwMjM0MTZ9.q1HEC10oBZQ3OpmeH8GSDeySREBYiKbtFo9cTGbxGdY", forHTTPHeaderField: "Authorization")

        URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            guard let data = data else {
                print("No data in response: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .flexibleISO8601
            do {
                let decodedResponse = try decoder.decode(ApiResponse.self, from: data)
                DispatchQueue.main.async {
                    self?.posts = decodedResponse.data.map { $0.attributes }
                }
            } catch {
                print("Failed to decode JSON: \(error)")
            }
        }.resume()
    }
}





struct HomeView: View {
    @ObservedObject var viewModel = PostViewModel()

    var body: some View {
        NavigationView {
            List(viewModel.posts, id: \.description) { post in
                VStack(alignment: .leading) {
                    Text(post.description)
                    Text("Created at: \(post.createdAt, formatter: itemFormatter)")
                    if let postMedicines = post.post_medicines?.data {
                        ForEach(postMedicines, id: \.id) { postMedicine in
                            Text("Medicine ID: \(postMedicine.id)")
                            if let fabDate = postMedicine.attributes.fabricationDate {
                                Text("Fabrication Date: \(fabDate, formatter: itemFormatter)")
                            } else {
                                Text("Fabrication Date: Not available")
                            }
                            if let expDate = postMedicine.attributes.expirationDate {
                                Text("Expiration Date: \(expDate, formatter: itemFormatter)")
                            } else {
                                Text("Expiration Date: Not available")
                            }
                            Text("Quantity: \(postMedicine.attributes.quantity)")
                            VStack {
                                Text("Medicine Name: \(postMedicine.attributes.medicines.data.attributes.name)")
                                Text("Category: \(postMedicine.attributes.medicines.data.attributes.category)")
                                Text("Type: \(postMedicine.attributes.medicines.data.attributes.type)")
                            }
                        }
                    }
                }
            }
            .navigationTitle("Posts")
            .toolbar {
                            ToolbarItem(placement: .navigationBarTrailing) {
                                Button(action: {
                                    viewModel.fetchPosts()  // This triggers a refresh of the data.
                                }) {
                                    Text("Refresh")
                                }
                            }
                        }
            .onAppear {
                viewModel.fetchPosts()
            }
        }
    }

    private var itemFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .none
        return formatter
    }
}





#Preview {
    HomeView()
}
