//
//  home.swift
//  medidonate
//
//  Created by fares kassis on 21/3/2024.
//

import SwiftUI

enum Pages{
    case conversation1
}

struct home: View {
    @State var path: [Pages] = []
    @State private var showhomescreen = false
    @ObservedObject var viewModel = PostViewModel()
    @State private var messages: [Int: String] = [:]

    var body: some View {
        NavigationStack(path: $path) {
            ScrollView {
                VStack(alignment: .leading) {
                    NavigationLink(destination: createpost1().navigationBarBackButtonHidden()) {
                        HStack {
                            Image(systemName: "person.circle.fill")
                                .resizable(resizingMode: .tile)
                                .frame(width: 50, height: 50)
                                .padding(.leading)
                                .foregroundColor(.green)
                            Text("Create your post here")
                                .font(.title3)
                                .padding(.leading)
                        }
                        .padding(.top, 15)
                    }
                    .foregroundColor(.gray)
                    ForEach(viewModel.posts, id: \.id) { post in
                        VStack(alignment: .center) {
                            Rectangle()
                                .fill(Color.gray3)
                                .frame(width: 400, height: 8)
                                .offset(x: 2)
                                .padding(.top, 10)
                                .padding(.bottom, 10)
                            let userPermissions = post.attributes.users_permissions_user.data
                            let userID: Int? = userPermissions.id
                            HStack {
                                Image(systemName: "person.circle")
                                    .resizable(resizingMode: .tile)
                                    .frame(width: 50, height: 50)
                                    .padding(.leading)
                                    .foregroundColor(.primarycolor)
                                VStack(alignment: .leading) {
                                    Text("\(userPermissions.attributes.username)")
                                        .font(.title3)
                                        .fontWeight(.semibold)
                                }
                                .frame(width: 200, height: 50, alignment: .leading)
                                NavigationLink(destination: requestmedicine(viewModel: viewModel)
                                    .navigationBarBackButtonHidden()
                                    .onAppear {
                                        viewModel.selectPost(id: post.id)
                                    }) {
                                    ZStack {
                                        Group {
                                            Rectangle()
                                                .cornerRadius(10)
                                                .foregroundStyle(Color.primarycolor)
                                                .frame(width: 100, height: 50, alignment: .center)
                                            VStack {
                                                Text("Send")
                                                    .font(.headline)
                                                    .fontWeight(.semibold)
                                                    .multilineTextAlignment(.center)
                                                    .foregroundStyle(.white)
                                                Text("Request")
                                                    .font(.headline)
                                                    .fontWeight(.semibold)
                                                    .multilineTextAlignment(.center)
                                                    .foregroundStyle(.white)
                                            }
                                        }
                                        .padding(.trailing)
                                    }
                                }
                            }
                            Text("\(post.attributes.description)")
                                .frame(minWidth: 50, maxWidth: 370, minHeight: 20, maxHeight: 150, alignment: .leading)
                                .padding(.leading, 15)
                            if let photos = post.attributes.photos?.data {
                                ForEach(photos, id: \.id) { photo in
                                    if let photoUrl = URL(string: "http://localhost:1337" + photo.attributes.url) {
                                        AsyncImage(url: photoUrl) { phase in
                                            switch phase {
                                            case .empty:
                                                ProgressView()
                                                    .frame(width: 180, height: 250)
                                            case .success(let image):
                                                image
                                                    .resizable()
                                                    .frame(width: 200, height: 150)
                                            case .failure:
                                                Image(systemName: "photo")
                                                    .resizable()
                                                    .scaledToFit()
                                                    .frame(width: 180, height: 250)
                                                Text("Failed to load image.")
                                            @unknown default:
                                                EmptyView()
                                            }
                                        }
                                    } else {
                                        Text("Invalid URL")
                                    }
                                }
                            }
                            ZStack {
                                Group {
                                    RoundedRectangle(cornerRadius: 30)
                                        .frame(width: 350, height: 50)
                                        .padding(.all, 8)
                                        .foregroundColor(Color.white)
                                        .cornerRadius(30)
                                        .shadow(color: .black, radius: 2)
                                    TextField("Write your message", text: Binding(
                                        get: { messages[post.id, default: ""] },
                                        set: { messages[post.id] = $0 }
                                    ), axis: .vertical)
                                        .frame(width: 280, height: 50)
                                        .offset(x: -20)
                                    NavigationLink(
                                        destination: conversation1(viewModel: viewModel, messageText: messages[post.id, default: ""])
                                            .navigationBarBackButtonHidden()
                                            .onAppear {
                                                viewModel.selectPost(id: post.id)
                                                if let userID = userID {
                                                    viewModel.sendMessage(postID: post.id, userID: userID, messageText: messages[post.id, default: ""])
                                                }
                                            }
                                    ) {
                                        Image(systemName: "arrow.up.circle.fill")
                                            .foregroundColor(.primarycolor)
                                            .font(.largeTitle)
                                    }
                                    .offset(x: 150)
                                }
                            }
                            .padding(.top, 5)
                        }
                    }
                }
            }
            .navigationTitle("Medi-Donate")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(leading: NavigationLink(destination: settings().navigationBarBackButtonHidden(), label: {
                Image(systemName: "line.3.horizontal.circle.fill")
                    .foregroundColor(.primarycolor)
                    .font(.title)
            }), trailing: NavigationLink(destination: searchesall().navigationBarBackButtonHidden(), label: {
                Image(systemName: "magnifyingglass.circle.fill")
                    .foregroundColor(.primarycolor)
                    .font(.title)
            }))
        }
        .onAppear {
            viewModel.fetchPosts()
        }
    }
}

#Preview {
    home()
}

import SwiftUI


struct conversation1: View {
    @ObservedObject var viewModel: PostViewModel
    var messageText: String

    var body: some View {
        NavigationView {
            VStack {
                ZStack {
                    VStack {
                        if let selectedPostID = viewModel.selectedPostID {
                            Image(systemName: "person.circle")
                                .resizable(resizingMode: .tile)
                                .frame(width: 50, height: 50)
                                .foregroundColor(.primarycolor)
                            if let username = viewModel.selectedPostUsername {
                                HStack {
                                    Text(username)
                                        .font(.headline)
                                        .foregroundColor(.black)
                                }
                            }
                        }
                    }
                    .offset(y: -20)
                }
                ScrollView {
                    if let latestMessage = viewModel.latestMessage {
                        let isCurrentUser = latestMessage.attributes.users_permissions_users.data.first?.id == (AuthService.userID ?? RegisterService.userID)
                        HStack {
                            if !isCurrentUser { Spacer() }
                            ZStack {
                                RoundedRectangle(cornerRadius: 15)
                                    .foregroundStyle(.primarycolor)
                                    .frame(width: 250, height: 80, alignment: .leading)
                                VStack(alignment: .leading) {
                                    Text(latestMessage.attributes.message)
                                        .frame(width: 225)
                                        .fontWeight(.medium)
                                        .foregroundColor(.white)
                                        .padding(isCurrentUser ? .leading : .trailing, 10)
                                }
                            }
                            if isCurrentUser { Spacer() }
                        }
                    } else {
                        Text("No messages available")
                            .font(.headline)
                            .padding()
                    }
                }
                .frame(width: 390.0)
                VStack {
                    ZStack {
                        Group {
                            RoundedRectangle(cornerRadius: 30)
                                .frame(width: 350, height: 50)
                                .padding(.all, 8)
                                .foregroundColor(Color.white)
                                .cornerRadius(30)
                                .shadow(color: .black, radius: 2)
                            TextField("Aa", text: .constant(""), axis: .vertical)
                                .frame(width: 280, height: 50)
                                .offset(x: -20)
                            Button(action: {
                                if let selectedPostID = viewModel.selectedPostID,
                                   let userID = AuthService.userID ?? RegisterService.userID {
                                    viewModel.sendMessage(postID: selectedPostID, userID: userID, messageText: messageText)
                                    viewModel.fetchMessages(for: selectedPostID)
                                }
                            }) {
                                Image(systemName: "arrow.up.circle.fill")
                                    .foregroundColor(Color("primarycolor"))
                                    .font(.system(size: 35))
                            }
                            .offset(x: 150)
                        }
                    }
                }
            }
            .navigationBarItems(leading: NavigationLink(destination: home().navigationBarBackButtonHidden(), label: {
                Image(systemName: "chevron.backward")
                    .font(.title2)
                    .foregroundColor(.black)
            }))
            .onAppear {
                if let selectedPostID = viewModel.selectedPostID {
                    viewModel.fetchMessages(for: selectedPostID)
                }
            }
        }
    }
}

struct conversation1_Previews: PreviewProvider {
    static var previews: some View {
        conversation1(viewModel: PostViewModel(), messageText: "Preview message")
    }
}



#Preview {
    conversation1(viewModel: PostViewModel(), messageText: "Preview message")
}






