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
                                .frame(width: 365, height: 100)
                            HStack(spacing: 5){
                                Image(systemName: "tray.and.arrow.down")
                                    .font(.system(size: 60))
                                    .foregroundColor(.primarycolor)
                                VStack(alignment: .leading){
                                    HStack{
                                        Text("Received it At:")
                                            .fontWeight(.bold)
                                            .font(.headline)
                                            .lineLimit(1)
                                            .layoutPriority(1)
                                        Text(request.attributes.createdAt)
                                            .font(.body)
                                            .lineLimit(1)
                                    }
                                    if let users = request.attributes.users_permissions_users?.data {
                                        ForEach(users, id: \.id) { user in
                                            HStack{
                                                Text("Sender:")
                                                    .fontWeight(.bold)
                                                    .font(.headline)
                                                Text(user.attributes.username)
                                                    .font(.body)
                                            }
                                        }
                                    } else {
                                        Text("No User Data")
                                    }
                                    if let postData = request.attributes.post.data {
                                        HStack{
                                            Text("Post Description:")
                                                .fontWeight(.bold)
                                                .font(.headline)
                                                .lineLimit(1)
                                                .layoutPriority(1)
                                            Text(postData.attributes.description)
                                                .font(.body)
                                                .lineLimit(1)
                                        }
                                    } else {
                                        Text("No Post Data")
                                    }
                                }
                                .frame(width: 275, height: 100, alignment: .leading)
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
