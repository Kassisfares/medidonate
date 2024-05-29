//
//  HomeView.swift
//  medidonate
//
//  Created by fares kassis on 12/5/2024.
//

import SwiftUI
import Foundation


class PostViewModel: ObservableObject {
    @Published var posts = [PostData]()
    @Published var selectedPostID: Int?
    @Published var selectedPostMedicines: [PostData] = []
    @Published var requests: [RequestData] = []
    @Published var recentRequest: RequestData?
    @Published var recentRequests: [RequestData] = []
    @Published var showhomescreen = false
    @Published var showAlert = false
    @Published var alertMessage = ""
    @Published var confirmRequest = false
    @Published var selectedPostUsername: String?
    @Published var latestMessages = [MessageDataContainer]()
    @Published var latestMessage: MessageDataContainer? // Add this property
    @Published var messageOwners: [Int: String] = [:] // To store the username of the post owners


    
    func fetchPosts() {
        guard let url = URL(string: "http://localhost:1337/api/posts?populate[users_permissions_user]=*&populate[post_medicines][populate]=medicines&populate[photos]=*") else {
            print("Invalid URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        if let token = AuthService.token ?? RegisterService.token {
            request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        } else {
            print("Authorization token is not available.")
            // Optionally handle the scenario when there is no token (e.g., show login screen)
            return
        }
        
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
                    self?.posts = decodedResponse.data.sorted { $0.attributes.createdAt > $1.attributes.createdAt }                }
            } catch {
                print("Failed to decode JSON: \(error)")
            }
        }.resume()
    }
    
    func selectPost(id: Int) {
        self.selectedPostID = id
        fetchMedicines(for: id)
        fetchUsername(for: id)
    }
    
    func fetchMedicines(for postID: Int) {
        // Your API call logic to fetch medicines for the selected post
        guard let url = URL(string: "http://localhost:1337/api/posts\(postID)?populate[post_medicines][populate]=medicines") else {
            print("Invalid URL")
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let response = try decoder.decode(ApiResponse.self, from: data)
                    DispatchQueue.main.async {
                        self.selectedPostMedicines = response.data
                    }
                } catch {
                    print("Error decoding medicines: \(error)")
                }
            }
        }.resume()
    }
    
    func search() {
        guard let url = URL(string: "http://localhost:1337/api/posts?populate[users_permissions_user]=*&populate[post_medicines][populate]=medicines&populate[photos]=*") else {
            print("Invalid URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        if let token = AuthService.token ?? RegisterService.token {
            request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        } else {
            print("Authorization token is not available.")
            return
        }
        
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
                    self?.posts = decodedResponse.data.sorted { $0.attributes.createdAt > $1.attributes.createdAt }
                }
            } catch {
                print("Failed to decode JSON: \(error)")
            }
        }.resume()
    }
    
    func loginAndFetchUser(email: String, password: String) {
        AuthService.loginrequest(email: email, password: password) { success in
            DispatchQueue.main.async {
                if success {
                    self.showhomescreen = true
                } else {
                    self.alertMessage = "Invalid email or password. Please try again."
                    self.showAlert = true
                }
            }
        }
    }
    
    func registerUser(name: String, phone: String, email: String, password: String) {
        RegisterService.registerrequest(name: name, phone_number: phone, email: email, password: password) { success in
            DispatchQueue.main.async {
                if success {
                    self.showhomescreen = true
                } else {
                    self.alertMessage = "Registration failed. Please try again."
                    self.showAlert = true
                }
            }
        }
    }
    
    func sendPostInformation(_ post: PostData, completion: @escaping (Bool) -> Void) {
        guard let url = URL(string: "http://localhost:1337/api/requests") else {
            print("Invalid URL")
            completion(false)
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        if let token = AuthService.token ?? RegisterService.token {
            request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        } else {
            print("Authorization token is not available.")
            completion(false)
            return
        }
        
        guard let userID = AuthService.userID ?? RegisterService.userID else {
            print("User ID is not available.")
            completion(false)
            return
        }
        
        print("User ID: \(userID)")
        
        let postInfo: [String: Any] = [
            "data": [
                "post": post.id,
                "users_permissions_users": userID
            ]
        ]
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: postInfo, options: [])
        } catch {
            print("Failed to encode JSON: \(error)")
            completion(false)
            return
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error sending post information: \(error)")
                completion(false)
                return
            }
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                print("Unexpected response status: \(response.debugDescription)")
                completion(false)
                return
            }
            print("Post information sent successfully")
            completion(true)
        }.resume()
    }
    
    func fetchRequests() {
        guard let url = URL(string: "http://localhost:1337/api/requests?populate=*") else {
            print("Invalid URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        if let token = AuthService.token ?? RegisterService.token {
            request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        } else {
            print("Authorization token is not available.")
            // Optionally handle the scenario when there is no token (e.g., show login screen)
            return
        }
        
        URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            guard let data = data else {
                print("No data in response: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            do {
                let decodedResponse = try decoder.decode(RequestResponse.self, from: data)
                DispatchQueue.main.async {
                    self?.recentRequest = decodedResponse.data.sorted { $0.attributes.createdAt > $1.attributes.createdAt }.first
                }
            } catch {
                print("Failed to decode JSON: \(error)")
            }
        }.resume()
    }
    
    func fetchUsername(for postID: Int) {
        guard let post = posts.first(where: { $0.id == postID }) else { return }
        self.selectedPostUsername = post.attributes.users_permissions_user.data.attributes.username
    }
    
    func fetchMessages(for postID: Int) {
            print("Fetching messages for post ID: \(postID)")
            guard let url = URL(string: "http://localhost:1337/api/messages?filters[post][id]=\(postID)&populate=*") else { return }

            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            
            if let token = AuthService.token ?? RegisterService.token {
                request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            } else {
                print("Authorization token is not available.")
                return
            }

            URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    print("Error fetching messages: \(error)")
                    return
                }
                guard let data = data else {
                    print("No data returned from server")
                    return
                }

                do {
                    let response = try JSONDecoder().decode(MessageResponse.self, from: data)
                    DispatchQueue.main.async {
                        self.latestMessages = response.data.sorted(by: { $0.attributes.createdAt > $1.attributes.createdAt })
                        self.latestMessage = self.latestMessages.first // Assign the first (latest) message
                        print("Fetched messages: \(self.latestMessages)")
                        print("Latest message: \(String(describing: self.latestMessage))")
                    }
                } catch {
                    print("Error decoding messages: \(error)")
                }
            }.resume()
        }

        func fetchPost(completion: @escaping () -> Void) {
            print("Fetching posts")
            guard let url = URL(string: "http://localhost:1337/api/posts?populate[users_permissions_user]=*") else { return }

            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            
            if let token = AuthService.token ?? RegisterService.token {
                request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            } else {
                print("Authorization token is not available.")
                return
            }

            URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    print("Error fetching posts: \(error)")
                    return
                }
                guard let data = data else {
                    print("No data returned from server")
                    return
                }

                do {
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .flexibleISO8601
                    let response = try decoder.decode(ApiResponse.self, from: data)
                    DispatchQueue.main.async {
                        self.posts = response.data
                        // Store the usernames of the post owners
                        for post in response.data {
                            self.messageOwners[post.id] = post.attributes.users_permissions_user.data.attributes.username
                        }
                        print("Fetched posts: \(self.posts)")
                        completion()
                    }
                } catch {
                    print("Error decoding posts: \(error)")
                }
            }.resume()
        }

        func sendMessage(postID: Int, userID: Int, messageText: String) {
            guard let url = URL(string: "http://localhost:1337/api/messages") else { return }

            let messageData = [
                "data": [
                    "message": messageText,
                    "users_permissions_user": userID,
                    "post": postID
                ]
            ]

            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            if let token = AuthService.token ?? RegisterService.token {
                request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            } else {
                print("Authorization token is not available.")
                return
            }

            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: messageData, options: [])
            } catch {
                print("Error encoding message data: \(error)")
                return
            }

            URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    print("Error sending message: \(error)")
                    return
                }
                guard let data = data else {
                    print("No data returned from server")
                    return
                }
                print("Message sent successfully: \(String(describing: String(data: data, encoding: .utf8)))")
            }.resume()
        }
}

struct Message: Identifiable {
    let id: Int
    let attributes: MessageAttributes
}

struct MessageResponse: Codable {
    let data: [MessageDataContainer]
}

struct MessageDataContainer: Codable, Identifiable {
    let id: Int
    let attributes: MessageAttributes
}

struct MessageAttributes: Codable {
    let message: String
    let createdAt: String
    let updatedAt: String
    let publishedAt: String
    let users_permissions_users: UserDataWrapper
    let post: PostDataContainer
}

struct UserDataWrapper: Codable {
    let data: [UserDataContainer]
}

struct UserDataContainer: Codable {
    let id: Int
    let attributes: UserAttributes1
}

struct UserAttributes1: Codable {
    let username: String
}

struct PostDataContainer: Codable {
    let data: PostData3?
}

struct PostData3: Codable {
    let id: Int
    let attributes: PostAttributes3
}

struct PostAttributes3: Codable {
    let description: String
    let createdAt: String
    let updatedAt: String
    let publishedAt: String
    let message: String?
}
