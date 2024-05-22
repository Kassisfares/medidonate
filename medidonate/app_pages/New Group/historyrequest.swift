//
//  ContentView.swift
//  medidonate
//
//  Created by fares kassis on 7/3/2024.
//

import SwiftUI

struct historyrequest: View {
    @StateObject var viewModel = PostViewModel()
    
    var body: some View {
        NavigationView {
            if let request = viewModel.recentRequest {
                                VStack(alignment: .leading) {
                                    Text("ID: \(request.id)")
                                    Text("Created At: \(request.attributes.createdAt)")
                                    Text("Updated At: \(request.attributes.updatedAt)")
                                    Text("Published At: \(request.attributes.publishedAt)")
                                    if let postData = request.attributes.post.data {
                                        Text("Post Description: \(postData.attributes.description)")
                                        if let message = postData.attributes.message {
                                            Text("Message: \(message)")
                                        }
                                    } else {
                                        Text("No Post Data")
                                    }
                                    // Display user information
                                    if let users = request.attributes.users_permissions_users?.data {
                                        ForEach(users, id: \.id) { user in
                                            VStack(alignment: .leading) {
                                                Text("User ID: \(user.id)")
                                                Text("Username: \(user.attributes.username)")
                                                Text("Email: \(user.attributes.email)")
                                                Text("Provider: \(user.attributes.provider)")
                                                Text("Confirmed: \(user.attributes.confirmed ? "Yes" : "No")")
                                                Text("Blocked: \(user.attributes.blocked ? "Yes" : "No")")
                                                Text("User Created At: \(user.attributes.createdAt)")
                                                Text("User Updated At: \(user.attributes.updatedAt)")
                                                if let phone = user.attributes.phone {
                                                    Text("Phone: \(phone)")
                                                }
                                            }
                                            .padding(.top, 10)
                                        }
                                    } else {
                                        Text("No User Data")
                                    }
                                }
                                .padding(.vertical, 10)
                            } else {
                                Text("Loading...")
                            }
                        }
            .navigationTitle("Requests")
            .onAppear {
                viewModel.fetchRequests()
            }
        }
    }

#Preview {
    historyrequest()
}
