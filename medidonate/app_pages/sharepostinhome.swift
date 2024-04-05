//
//  home.swift
//  medidonate
//
//  Created by fares kassis on 21/3/2024.
//

import SwiftUI

struct sharepostinhome: View {
    @State var comment: String = ""
    var body: some View {
        NavigationView{
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
                    VStack(alignment: .center){
                        HStack{
                            Image(systemName: "person.circle.fill")
                                .resizable(resizingMode: .tile)
                                .frame(width: 50, height: 50)
                                .foregroundColor(.green)
                            VStack(alignment: .leading){
                                Text("Freas Kassis")
                                    .font(.title3)
                                    .fontWeight(.semibold)
                                Text("30m")
                                    .font(.callout)
                                    .foregroundColor(.gray4)
                            }
                            .frame(width: 200, height: 50, alignment: .leading)
                        }
                        .offset(x: -38)
                        VStack{
                            Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Lorem ipsum dolor sit amet, consectetur.")
                                .frame(width: 360, height: 80, alignment: .leading)
                                .padding(.leading, 25)
                        }
                        HStack(alignment: .center, spacing: 10){
                            Image("panadol")
                                .resizable(resizingMode: .stretch)
                                .frame(width: 180, height: 250)
                        }
                        .padding(.leading, 18)
                        ZStack{
                            Group{
                                TextField("hello! is this medicine still available ?", text: $comment)
                                    .frame(width: 330, height: 30)
                                    .padding()
                                    .background(Color.white)
                                    .cornerRadius(30)
                                    .shadow(color: .black, radius: 2)
                                NavigationLink(destination: createpost().navigationBarBackButtonHidden(), label: {Image(systemName: "arrow.up.circle.fill")
                                        .foregroundColor(Color("primarycolor"))
                                        .font(.largeTitle)})
                                .offset(x: 155)
                            }
                            .padding(.leading)
                            .padding(.top, 5)
                        }
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
                                TextField("hello! is this medicine still available ?", text: $comment)
                                    .frame(width: 330, height: 30)
                                    .padding()
                                    .background(Color.white)
                                    .cornerRadius(30)
                                    .shadow(color: .black, radius: 2)
                                NavigationLink(destination: createpost().navigationBarBackButtonHidden(), label: {Image(systemName: "arrow.up.circle.fill")
                                        .foregroundColor(Color("primarycolor"))
                                        .font(.largeTitle)})
                                .offset(x: 155)
                            }
                            .padding(.leading)
                            .padding(.top, 5)
                        }
                    }
                }
            }
            .navigationTitle("Medi-Donate")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(leading: NavigationLink(destination: settings().navigationBarBackButtonHidden(), label: {Image(systemName: "line.3.horizontal.circle.fill").foregroundColor(.primarycolor)
                .font(.title)}),trailing: Image(systemName: "magnifyingglass.circle.fill")
                .foregroundColor(.primarycolor)
                .font(.title))
        }
    }
}
#Preview {
    sharepostinhome()
}

