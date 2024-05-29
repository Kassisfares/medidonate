import SwiftUI

struct message: View {
    @State var search: String = ""
    @ObservedObject var viewModel = PostViewModel()

    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    searchField
                    latestMessageView
                }
            }
            .navigationTitle("Messages")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(leading: backButton)
        }
        .onAppear {
            viewModel.fetchPost {
                let knownPostWithMessagesID = 318 // Replace with a known post ID that has messages
                print("Fetching messages for the known post ID: \(knownPostWithMessagesID)")
                viewModel.fetchMessages(for: knownPostWithMessagesID)
            }
        }
    }

    private var searchField: some View {
        ZStack {
            TextField("search", text: $search)
                .frame(width: 330, height: 20)
                .padding()
                .background(Color.gray5)
                .cornerRadius(20)
                .foregroundColor(.gray)
            Image(systemName: "magnifyingglass")
                .foregroundColor(.gray)
                .offset(x: 150)
        }
    }

    private var latestMessageView: some View {
        VStack {
            if let latestMessage = viewModel.latestMessage, let postId = latestMessage.attributes.post.data?.id {
                if let ownerUsername = viewModel.messageOwners[postId] {
                    messageItem(message: latestMessage, postId: postId, ownerUsername: ownerUsername)
                } else {
                    Text("Owner username not found")
                        .font(.headline)
                        .padding()
                }
            } else {
                Text("No messages available")
                    .font(.headline)
                    .padding()
            }
        }
        .padding(.leading)
    }

    private func messageItem(message: MessageDataContainer, postId: Int, ownerUsername: String) -> some View {
        let destination = conversation(viewModel: viewModel, postId: postId, messageText: message.attributes.message, ownerUsername: ownerUsername).navigationBarBackButtonHidden()

        return HStack {
            NavigationLink(destination: destination) {
                Image(systemName: "person.circle")
                    .resizable(resizingMode: .tile)
                    .frame(width: 50, height: 50)
                    .padding(.trailing, 10)
                    .foregroundColor(.primarycolor)
                VStack(alignment: .leading) {
                    Text(ownerUsername)
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                    Text(message.attributes.message)
                        .frame(width: 200, height: 50, alignment: .leading)
                        .font(.callout)
                        .fontWeight(.light)
                        .foregroundColor(.gray)
                        .padding(.top, -15)
                }
            }
        }
        .padding(.leading, -100)
        .padding(.top, 30)
    }

    private var backButton: some View {
        NavigationLink(destination: settings().navigationBarBackButtonHidden(), label: {
            Image(systemName: "chevron.backward")
                .font(.title2)
                .foregroundColor(.black)
        })
    }
}

#Preview {
    message()
}
