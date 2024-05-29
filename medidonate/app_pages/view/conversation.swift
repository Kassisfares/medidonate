import SwiftUI

struct conversation: View {
    @State var messages: String = ""
    @ObservedObject var viewModel: PostViewModel
    var postId: Int
    var messageText: String
    var ownerUsername: String

    var body: some View {
        NavigationView {
            VStack {
                ownerInfo
                messagesScrollView
                messageInput
            }
            .navigationBarItems(leading: backButton)
            .onAppear {
                viewModel.selectedPostID = postId
                viewModel.fetchMessages(for: postId)
            }
        }
    }

    private var ownerInfo: some View {
        VStack {
            Image(systemName: "person.circle")
                .resizable(resizingMode: .tile)
                .frame(width: 50, height: 50)
                .foregroundColor(.primarycolor)
            HStack {
                Text(ownerUsername)
                    .font(.headline)
                    .foregroundColor(.black)
            }
        }
        .offset(y: -20)
    }

    private var messagesScrollView: some View {
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
    }

    private var messageInput: some View {
        ZStack {
            Group {
                RoundedRectangle(cornerRadius: 30)
                    .frame(width: 350, height: 50)
                    .padding(.all, 8)
                    .foregroundColor(Color.white)
                    .cornerRadius(30)
                    .shadow(color: .black, radius: 2)
                TextField("Aa", text: $messages, axis: .vertical)
                    .frame(width: 280, height: 50)
                    .offset(x: -20)
                Button(action: {
                    if let selectedPostID = viewModel.selectedPostID,
                       let userID = AuthService.userID ?? RegisterService.userID {
                        viewModel.sendMessage(postID: selectedPostID, userID: userID, messageText: messages)
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

    private var backButton: some View {
        NavigationLink(destination: message().navigationBarBackButtonHidden(), label: {
            Image(systemName: "chevron.backward")
                .font(.title2)
                .foregroundColor(.black)
        })
    }
}

#Preview {
    conversation(viewModel: PostViewModel(), postId: 320, messageText: "Preview message", ownerUsername: "Preview Owner")
}
