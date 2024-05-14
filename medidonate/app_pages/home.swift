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
    
    @State var comment1: String = ""
    @State var comment2: String = ""
    @State var comment3: String = ""
    @State var path: [Pages] = []
    
    @ObservedObject var viewModel = PostViewModel()
    
    var body: some View {
        NavigationStack(path: $path){
            ScrollView{
                VStack(alignment: .leading){
                    NavigationLink(destination: createpost1().navigationBarBackButtonHidden()){
                        HStack{
                                Image(systemName: "person.circle.fill")
                                    .resizable(resizingMode: .tile)
                                    .frame(width: 50, height: 50)
                                    .padding(.leading)
                                    .foregroundColor(.green)
                                    Text("Write your post here")
                                        .font(.title3)
                                        .padding(.leading)
                                }
                                .padding(.top, 15)
                    }
                    .foregroundColor(.gray)
                    ForEach(viewModel.posts, id: \.id) { post in
                        VStack(alignment: .center){
                            Rectangle()
                                .fill(Color.gray3)
                                .frame(width:400, height: 8)
                                .offset(x: 2)
                                .padding(.top, 10)
                                .padding(.bottom, 10)
                            let userPermissions = post.attributes.users_permissions_user.data
                            HStack{
                                Image(systemName: "person.circle")
                                    .resizable(resizingMode: .tile)
                                    .frame(width: 50, height: 50)
                                    .padding(.leading)
                                    .foregroundColor(.primarycolor)
                                VStack(alignment: .leading){
                                    Text("\(userPermissions.attributes.username)")
                                        .font(.title3)
                                        .fontWeight(.semibold)
                                    Text("30m")
                                        .font(.callout)
                                        .foregroundColor(.gray4)
                                }
                                .frame(width: 200, height: 50, alignment: .leading)
                                NavigationLink(destination: requestmedicine().navigationBarBackButtonHidden()){
                                    ZStack(){
                                        Group{
                                            Rectangle()
                                                .cornerRadius(10)
                                                .foregroundStyle(Color.primarycolor)
                                                .frame(width: 100, height: 50, alignment: .center)
                                            VStack{
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
                            NavigationLink(destination: requestmedicine().navigationBarBackButtonHidden()){
                                ZStack(){
                                    HStack(alignment: .center, spacing: 10){
                                        Image("panadol")
                                            .resizable(resizingMode: .stretch)
                                            .frame(width: 180, height: 250)
                                        Image("vaccin")
                                            .resizable(resizingMode: .stretch)
                                            .frame(width: 180, height: 250)
                                    }
                                }
                            }
                            ZStack{
                                Group{
                                    RoundedRectangle(cornerRadius: 30)
                                        .frame(width: 350, height: 50)
                                        .padding(.all, 8)
                                        .foregroundColor(Color.white)
                                        .cornerRadius(30)
                                        .shadow(color: .black, radius: 2)
                                    TextField("Write your message", text: $comment1, axis: .vertical)
                                        .frame(width: 280, height: 50)
                                        .offset(x: -20)
                                    Button {
                                        path.append(Pages.conversation1)
                                    } label: {
                                    Image(systemName: "arrow.up.circle.fill")
                                }
                                    .foregroundColor(Color("primarycolor"))
                                    .font(.largeTitle)
                                    .offset(x: 150)
                                }
                            }
                            .padding(.leading)
                            .padding(.top, 5)
                        }
                    }
                }
                .onAppear {
                    viewModel.fetchPosts()
                }
            }
            .navigationTitle("Medi-Donate")
            .navigationDestination(for: Pages.self, destination: { page in
                Navigator.navigate(page: page)
            })
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(leading: NavigationLink(destination: settings().navigationBarBackButtonHidden(), label: {Image(systemName: "line.3.horizontal.circle.fill").foregroundColor(.primarycolor)
                .font(.title)}),trailing: NavigationLink(destination: searchesall().navigationBarBackButtonHidden(), label: {Image(systemName: "magnifyingglass.circle.fill")
                        .foregroundColor(.primarycolor)
                        .font(.title)}))
        }
    }
}
#Preview {
    home()
}

struct Navigator{
    @ViewBuilder
    static func navigate(page: Pages) -> some View{
        switch page {
        case .conversation1:
            conversation1()
        }
    }
}


//
//  settings.swift
//  medidonate
//
//  Created by fares kassis on 11/3/2024.
//

import SwiftUI


struct conversation1: View {
    @State var messages: String = ""
    var body: some View {
        NavigationView{
            VStack {
                ZStack{
                        VStack{
                            Image(systemName: "person.circle.fill")
                                .resizable(resizingMode: .tile)
                                .frame(width: 50, height: 50)
                                .padding(.leading, 5)
                            HStack{
                                Text("Stephen Yustiono")
                                    .font(.footnote)
                                    .foregroundColor(.black)
                            }
                        }
                        .offset(y: -20)
                }
                ScrollView{
                    ForEach(0..<10){ index in
                        let condition = index%2 == 0
                        let condition1 = index%1 == 1
                        ZStack{
                            RoundedRectangle(cornerRadius: 15)
                                .foregroundStyle(condition ? Color(.gray4) : Color(.primarycolor))
                                .frame(width: 250, height: 80, alignment: .leading)
                                .padding(condition ? .leading : .trailing, -100)
                            VStack(alignment: .leading){
                                Text("Lorem ipsum dolor sit amet, consectetur.")
                                    .frame(width: 225)
                                    .fontWeight(.medium)
                                    .foregroundColor(.white)
                                    .padding(condition ? .leading : .trailing, -100)
                                    .padding(condition1 ? .leading : .trailing, -10)
                            }
                        }
                    }
                    .frame(width: 390.0)
                }
                VStack {
                    ZStack{
                        Group{
                            RoundedRectangle(cornerRadius: 30)
                                .frame(width: 350, height: 50)
                                .padding(.all, 8)
                                .foregroundColor(Color.white)
                                .cornerRadius(30)
                                .shadow(color: .black, radius: 2)
                            TextField("Aa", text: $messages, axis: .vertical)
                                .frame(width: 280, height: 50)
                                .offset(x: -20)
                            NavigationLink(destination: conversation().navigationBarBackButtonHidden(), label: {Image(systemName: "arrow.up.circle.fill")
                                    .foregroundColor(Color("primarycolor"))
                                .font(.system(size: 35))})
                            .offset(x: 150)
                        }
                    }
                }
            }
        }
    }
}
#Preview {
    conversation1()
}






