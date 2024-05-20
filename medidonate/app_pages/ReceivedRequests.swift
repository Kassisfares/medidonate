//
//  ContentView.swift
//  medidonate
//
//  Created by fares kassis on 7/3/2024.
//

import SwiftUI

struct ReceivedRequests: View {
    @StateObject var viewModel = PostViewModel()

    var body: some View {
        NavigationView(){
            ScrollView{
                ZStack{
                    Circle()
                        .fill(Color.primarycolor)
                        .frame(width: 1000, height: 575)
                        .offset(x: -180, y: -530)
                        .rotationEffect(.degrees(10))
                    Text("Received Requests")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(Color.white)
                        .offset(x: -55, y: -390)
                }
                .offset(y: 80)
                if let request = viewModel.recentRequest {
                        ZStack{
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color.gray4)
                                .cornerRadius(20)
                                .foregroundColor(.white)
                                .frame(width: 365, height: 150)
                            HStack(spacing: 10){
                                Image(systemName: "pills")
                                    .font(.system(size: 100))
                                    .foregroundColor(.primarycolor)
                                VStack(alignment: .leading){
                                    Text("Received it At: \(request.attributes.createdAt)")
                                    if let users = request.attributes.users_permissions_users?.data {
                                        ForEach(users, id: \.id) { user in
                                            VStack(alignment: .leading) {
                                                Text("From: \(user.attributes.username)")
                                            }
                                        }
                                    } else {
                                        Text("No User Data")
                                    }
                                    if let postData = request.attributes.post.data {
                                        Text("Post Description: \(postData.attributes.description)")
                                    } else {
                                        Text("No Post Data")
                                    }
                                }
                                .frame(width: 200, height: 100, alignment: .topLeading)
                            }
                        }
                        .offset(y: -450)
                }
            }
            .navigationBarItems(leading:NavigationLink(destination: settings().navigationBarBackButtonHidden(), label: {Image(systemName: "chevron.backward")
                    .font(.title2)
            .foregroundColor(.white)}))
            .onAppear {
                viewModel.fetchRequests()
            }
        }
    }
}
#Preview {
    ReceivedRequests()
}
