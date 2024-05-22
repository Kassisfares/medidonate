//
//  signup.swift
//  medidonate
//
//  Created by fares kassis on 7/3/2024.
//

import SwiftUI

struct searchesall: View {
    @State private var searchText = ""
    @State private var showingSearchResults = false
    @ObservedObject var viewModel1 = PostViewModel() // Use PostViewModel to fetch posts
    @State private var searchResults: [PostData] = []

    private func dismissKeyboard() {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
    
    
    var body: some View {
        NavigationView{
            ScrollView{
                ZStack{
                    Circle()
                        .fill(Color.primarycolor)
                        .frame(width: 5500, height: 575)
                        .offset( y: -440)
                    TextField("Medicine name", text: $searchText)
                        .frame(width: 300)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                        .onChange(of: searchText) { newValue in
                                            // This checks if the text field is not empty and then shows the search results
                                            if !newValue.isEmpty {
                                                showingSearchResults = true
                                                searchPosts()
                                            }
                                        }
                        .onTapGesture {
                            // This will toggle the display of the search results
                            if !searchText.isEmpty {
                                                    showingSearchResults = true

                                                }
                        }
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.gray, lineWidth: 1)
                        )
                        .padding(.horizontal)
                    .offset(y: -260)
                }
                if showingSearchResults && !searchText.isEmpty {
                    List {
                        ForEach(searchResults) { post in
                            VStack(alignment: .leading, spacing: 5) {
                                let userPermissions = post.attributes.users_permissions_user.data
                                Text("\(userPermissions.attributes.username)")
                                    .font(.headline)
                                Text("Description: \(post.attributes.description)")
                                    .font(.subheadline)
                                if let postMedicines = post.attributes.post_medicines?.data {
                                    ForEach(postMedicines, id: \.id) { postMedicine in
                                        Text("Medicine Name: \(postMedicine.attributes.medicines.data.attributes.name)")
                                        Text("Type: \(postMedicine.attributes.medicines.data.attributes.type)")
                                        Text("Quantity: \(postMedicine.attributes.quantity)")
                                    }
                                }
                            }
                            .foregroundColor(.black)
                            .padding()
                            .onTapGesture {
                                dismissKeyboard()
                            }
                        }
                    }
                    .frame(width: 390, height: 600, alignment: .center)
                    .background(Color.white)
                    .transition(.move(edge: .bottom))
                    .animation(.easeInOut(duration: 0.5))
                    .edgesIgnoringSafeArea(.bottom)
                    .offset(y:-430)
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(leading:NavigationLink(destination: home().navigationBarBackButtonHidden(), label: {Image(systemName: "chevron.backward")
                    .font(.title2)
                    .foregroundColor(.white)}))
        }
        .onAppear {
                    viewModel1.search()
                }
    }
    private func searchPosts() {
            searchResults = viewModel1.posts.filter { post in
                guard let postMedicines = post.attributes.post_medicines else { return false }
                return postMedicines.data.contains { medicineData in
                    medicineData.attributes.medicines.data.attributes.name.localizedCaseInsensitiveContains(self.searchText)
                }
            }
        }
}
#Preview {
    searchesall()
}
