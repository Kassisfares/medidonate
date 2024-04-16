//
//  home.swift
//  medidonate
//
//  Created by fares kassis on 21/3/2024.
//

import SwiftUI

enum Pages{
    case message1
    case conversation1
}

struct home: View {
    @State var comment1: String = ""
    @State var comment2: String = ""
    @State var path: [Pages] = []
    var body: some View {
        NavigationStack(path: $path){
            ScrollView{
                VStack(alignment: .leading){
                    NavigationLink(destination: createpost().navigationBarBackButtonHidden()){
                        HStack{
                                Image(systemName: "person.circle.fill")
                                    .resizable(resizingMode: .tile)
                                    .frame(width: 50, height: 50)
                                    .padding(.leading, 25)
                                    .foregroundColor(.green)
                                    Text("What's on your mind ?")
                                        .font(.title3)
                                        .padding(.leading, 15)
                                }
                                .padding(.top, 15)
                    }
                    .foregroundColor(.gray)
                    Rectangle()
                        .fill(Color.gray3)
                        .frame(width:400, height: 8)
                        .offset(x: 2)
                        .padding(.top, 10)
                        .padding(.bottom, 10)
                    ForEach(0..<10){ index in
                        VStack(alignment: .center){
                            HStack{
                                Image(systemName: "person.circle.fill")
                                    .resizable(resizingMode: .tile)
                                    .frame(width: 50, height: 50)
                                    .padding(.leading, 25)
                                VStack(alignment: .leading){
                                    Text("Stephen Yustiono")
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
                                    }
                                }
                            }
                            VStack{
                                Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Lorem ipsum dolor sit amet, consectetur.")
                                    .frame(width: 360, height: 80, alignment: .leading)
                                    .padding(.leading, 25)
                            }
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
                            .padding(.leading, 18)
                            ZStack{
                                Group{
                                    RoundedRectangle(cornerRadius: 30)
                                        .frame(width: 350, height: 50)
                                        .padding(.all, 8)
                                        .foregroundColor(Color.white)
                                        .cornerRadius(30)
                                        .shadow(color: .black, radius: 2)
                                    TextField("hello! is this medicine still available ?", text: $comment1, axis: .vertical)
                                        .frame(width: 280, height: 50)
                                        .offset(x: -20)
                                    Button {
                                        path.append(Pages.message1)
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
                        Rectangle()
                            .fill(Color.gray3)
                            .frame(width:400, height: 8)
                            .offset(x: 2)
                            .padding(.top, 10)
                            .padding(.bottom, 10)
                        VStack(alignment: .center){
                            HStack{
                                Image(systemName: "person.circle.fill")
                                    .resizable(resizingMode: .tile)
                                    .frame(width: 50, height: 50)
                                    .padding(.leading, 25)
                                    .foregroundColor(.red)
                                VStack(alignment: .leading){
                                    Text("Erin Steed")
                                        .font(.title3)
                                        .fontWeight(.semibold)
                                    Text("30m")
                                        .font(.callout)
                                        .foregroundColor(.gray4)
                                }
                                .frame(width: 200, height: 50, alignment: .leading)
                                NavigationLink(destination: createpost().navigationBarBackButtonHidden()){
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
                                    }
                                }
                            }
                            VStack{
                                Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Lorem ipsum dolor sit amet, consectetur.")
                                    .frame(width: 360, height: 80, alignment: .leading)
                                    .padding(.leading, 25)
                            }
                            HStack(alignment: .center, spacing: 10){
                                Image("claritine")
                                    .resizable(resizingMode: .stretch)
                                    .frame(width: 200, height: 250)
                            }
                            .padding(.leading, 18)
                            ZStack{
                                Group{
                                    RoundedRectangle(cornerRadius: 30)
                                        .frame(width: 350, height: 50)
                                        .padding(.all, 8)
                                        .foregroundColor(Color.white)
                                        .cornerRadius(30)
                                        .shadow(color: .black, radius: 2)
                                    TextField("hello! is this medicine still available ?", text: $comment2, axis: .vertical)
                                        .frame(width: 280, height: 50)
                                        .offset(x: -20)
                                    Button {
                                        path.append(Pages.message1)
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
        case .message1:
            message1()
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
import ExyteChat


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
                }
                ScrollView{
                    ForEach(0..<10){ index in
                        ZStack{
                            RoundedRectangle(cornerRadius: 15)
                                .foregroundStyle(Color.primarycolor)
                                .frame(width: 250, height: 80, alignment: .center)
                            VStack(alignment: .leading){
                                Text("Lorem ipsum dolor sit")
                                    .fontWeight(.medium)
                                    .foregroundColor(.white)
                                Text("amet, consectetur.")
                                    .fontWeight(.medium)
                                    .foregroundColor(.white)
                            }
                            .padding(.leading, -50)
                        }
                    }
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

//
//  settings.swift
//  medidonate
//
//  Created by fares kassis on 11/3/2024.
//

import SwiftUI

struct message1: View {
    @State var search: String = ""
    var body: some View {
        NavigationView{
            ScrollView{
                VStack {
                    ZStack{
                        Group{
                            ZStack{
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
                            .offset(y: -350)
                        }
                        .offset(y: -50)
                        VStack{
                            ForEach(0..<10){ index in
                                HStack{
                                    Circle()
                                        .frame(width: 15, height: 15)
                                        .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                                        .padding(.leading, 25)
                                    NavigationLink(destination: conversation().navigationBarBackButtonHidden()){
                                        Image(systemName: "person.circle.fill")
                                            .resizable(resizingMode: .tile)
                                            .frame(width: 50, height: 50)
                                            .padding(.leading, 5)
                                        VStack(alignment: .leading){
                                            Text("Stephen Yustiono")
                                                .font(.title2)
                                                .fontWeight(.bold)
                                                .foregroundColor(.black)
                                            Text("Lorem ipsum dolor sit amet consectetur adipiscing elit.")
                                                .frame(width: 200, height: 50, alignment: .leading)
                                                .font(.callout)
                                                .fontWeight(.light)
                                                .foregroundColor(.gray)
                                                .padding(.top, -15)
                                        }
                                    }
                                }
                            }
                            .offset(x: -45, y:90)
                        }
                    }
                }
            }
            //.navigationTitle("Messages")
            //.navigationBarTitleDisplayMode(.inline)
        }
    }
}
#Preview {
    message1()
}







