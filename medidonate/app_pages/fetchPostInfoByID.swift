////
////  fetchPostInfoByID.swift
////  medidonate
////
////  Created by fares kassis on 14/5/2024.
////
//
//import SwiftUI
//
//struct fetchPostInfoByID: View {
//    @StateObject private var viewModel = PostViewModel()
//    @State private var postId: String = ""
//
//    var body: some View {
//        VStack {
//            TextField("Enter Post ID", text: $postId)
//                .padding()
//                .keyboardType(.numberPad)
//                .textFieldStyle(RoundedBorderTextFieldStyle())
//            
//            Button(action: {
//                if let id = Int(postId) {
//                    viewModel.fetchPostById(id)
//                }
//            }) {
//                Text("Fetch Post")
//                    .padding()
//                    .background(Color.blue)
//                    .foregroundColor(.white)
//                    .cornerRadius(8)
//            }
//            .padding()
//
//            if let post = viewModel.selectedPost {
//                VStack(alignment: .leading) {
//                    Text("Post ID: \(post.id)")
//                        .font(.headline)
//                    Text("Description: \(post.attributes.description)")
//                    Text("Created At: \(post.attributes.createdAt, formatter: DateFormatter.iso8601Full)")
//                    Text("Updated At: \(post.attributes.updatedAt, formatter: DateFormatter.iso8601Full)")
//                    Text("Published At: \(post.attributes.publishedAt, formatter: DateFormatter.iso8601Full)")
//                    
//                    if let message = post.attributes.message {
//                        Text("Message: \(message)")
//                    }
//
//                    Text("User: \(post.attributes.users_permissions_user.data.attributes.username)")
//
//                    if let medicines = post.attributes.post_medicines?.data {
//                        ForEach(medicines, id: \.id) { medicine in
//                            Text("Medicine ID: \(medicine.id)")
//                            Text("Name: \(medicine.attributes.medicines.data.attributes.name)")
//                            Text("Quantity: \(medicine.attributes.quantity)")
//                            if let fabricationDate = medicine.attributes.fabricationDate {
//                                Text("Fabrication Date: \(fabricationDate, formatter: DateFormatter.iso8601Full)")
//                            }
//                            if let expirationDate = medicine.attributes.expirationDate {
//                                Text("Expiration Date: \(expirationDate, formatter: DateFormatter.iso8601Full)")
//                            }
//                        }
//                    }
//                }
//                .padding()
//            } else {
//                Text("No post selected")
//                    .padding()
//            }
//        }
//        .padding()
//    }
//}
//
//struct PostView_Previews: PreviewProvider {
//    static var previews: some View {
//        fetchPostInfoByID()
//    }
//}
