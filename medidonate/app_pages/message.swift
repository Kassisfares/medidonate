//
//  settings.swift
//  medidonate
//
//  Created by fares kassis on 11/3/2024.
//

import SwiftUI

struct message: View {
    @State var search: String = ""
    var body: some View {
        NavigationView{
            ScrollView{
                VStack {
                    ZStack{
                        Group{
                            Rectangle()
                                .fill(Color.primarycolor)
                                .frame(width: 400, height: 180)
                            Text("Messages")
                                .font(.title2)
                                .foregroundColor(Color.white)
                                .offset(x: -100, y:-12)
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
                            .offset(y: 45)
                        }
                        .offset(y: -350)
                        VStack{
                            HStack{
                                Circle()
                                    .frame(width: 15, height: 15)
                                    .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                                    .padding(.leading, 25)
                                Image(systemName: "person.circle.fill")
                                    .resizable(resizingMode: .tile)
                                    .frame(width: 50, height: 50)
                                    .padding(.leading, 5)
                                VStack(alignment: .leading){
                                    Text("Stephen Yustiono")
                                        .font(.title2)
                                        .fontWeight(.bold)
                                    Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit.")
                                        .font(.callout)
                                        .fontWeight(.light)
                                        .foregroundColor(.gray)
                                }
                            }
                            HStack{
                                Circle()
                                    .frame(width: 15, height: 15)
                                    .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                                    .padding(.leading, 25)
                                Image(systemName: "person.circle.fill")
                                    .resizable(resizingMode: .tile)
                                    .frame(width: 50, height: 50)
                                    .padding(.leading, 5)
                                    .foregroundColor(.red)
                                VStack(alignment: .leading){
                                    Text("Stephen Yustiono")
                                        .font(.title2)
                                        .fontWeight(.bold)
                                    Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit.")
                                        .font(.callout)
                                        .fontWeight(.light)
                                        .foregroundColor(.gray)
                                }
                            }
                            HStack{
                                Circle()
                                    .frame(width: 15, height: 15)
                                    .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                                    .padding(.leading, 25)
                                Image(systemName: "person.circle.fill")
                                    .resizable(resizingMode: .tile)
                                    .frame(width: 50, height: 50)
                                    .padding(.leading, 5)
                                    .foregroundColor(.green)
                                VStack(alignment: .leading){
                                    Text("Stephen Yustiono")
                                        .font(.title2)
                                        .fontWeight(.bold)
                                    Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit.")
                                        .font(.callout)
                                        .fontWeight(.light)
                                        .foregroundColor(.gray)
                                }
                            }
                            HStack{
                                Image(systemName: "person.circle.fill")
                                    .resizable(resizingMode: .tile)
                                    .frame(width: 50, height: 50)
                                    .padding(.leading, 53)
                                    .foregroundColor(.yellow)
                                VStack(alignment: .leading){
                                    Text("Stephen Yustiono")
                                        .font(.title2)
                                        .fontWeight(.bold)
                                    Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit.")
                                        .font(.callout)
                                        .fontWeight(.light)
                                        .foregroundColor(.gray)
                                }
                            }
                            HStack{
                                Image(systemName: "person.circle.fill")
                                    .resizable(resizingMode: .tile)
                                    .frame(width: 50, height: 50)
                                    .padding(.leading, 53)
                                    .foregroundColor(.brown)
                                VStack(alignment: .leading){
                                    Text("Stephen Yustiono")
                                        .font(.title2)
                                        .fontWeight(.bold)
                                    Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit.")
                                        .font(.callout)
                                        .fontWeight(.light)
                                        .foregroundColor(.gray)
                                }
                            }
                            HStack{
                                Image(systemName: "person.circle.fill")
                                    .resizable(resizingMode: .tile)
                                    .frame(width: 50, height: 50)
                                    .padding(.leading, 53)
                                    .foregroundColor(.indigo)
                                VStack(alignment: .leading){
                                    Text("Stephen Yustiono")
                                        .font(.title2)
                                        .fontWeight(.bold)
                                    Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit.")
                                        .font(.callout)
                                        .fontWeight(.light)
                                        .foregroundColor(.gray)
                                }
                            }
                            HStack{
                                Image(systemName: "person.circle.fill")
                                    .resizable(resizingMode: .tile)
                                    .frame(width: 50, height: 50)
                                    .padding(.leading, 53)
                                    .foregroundColor(.teal)
                                VStack(alignment: .leading){
                                    Text("Stephen Yustiono")
                                        .font(.title2)
                                        .fontWeight(.bold)
                                    Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit.")
                                        .font(.callout)
                                        .fontWeight(.light)
                                        .foregroundColor(.gray)
                                }
                            }
                            HStack{
                                Image(systemName: "person.circle.fill")
                                    .resizable(resizingMode: .tile)
                                    .frame(width: 50, height: 50)
                                    .padding(.leading, 53)
                                    .foregroundColor(.pink)
                                VStack(alignment: .leading){
                                    Text("Stephen Yustiono")
                                        .font(.title2)
                                        .fontWeight(.bold)
                                    Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit.")
                                        .font(.callout)
                                        .fontWeight(.light)
                                        .foregroundColor(.gray)
                                }
                            }
                        }
                        .offset(x: -15, y:90)
                    }
                }
            }
            .navigationBarItems(leading:NavigationLink(destination: home().navigationBarBackButtonHidden(), label: {Image(systemName: "chevron.backward")
                    .font(.title2)
                    .foregroundColor(.white)}))
        }
    }
}
#Preview {
    message()
}


