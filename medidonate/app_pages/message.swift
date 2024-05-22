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
                        }
//                        .offset(y: -90)
                        VStack{
                                HStack{
                                    NavigationLink(destination: conversation().navigationBarBackButtonHidden()){
                                        Image(systemName: "person.circle")
                                            .resizable(resizingMode: .tile)
                                            .frame(width: 50, height: 50)
                                            .padding(.trailing, 10)
                                            .foregroundColor(.primarycolor)
                                        VStack(alignment: .leading){
                                            Text("Mohamed")
                                                .font(.title2)
                                                .fontWeight(.bold)
                                                .foregroundColor(.black)
                                            Text("Salut, ce medicament est disponible maintenant ??")
                                                .frame(width: 200, height: 50, alignment: .leading)
                                                .font(.callout)
                                                .fontWeight(.light)
                                                .foregroundColor(.gray)
                                                .padding(.top, -15)
                                        }
                                    }
                                }
                            .offset(x: -45, y:90)
//                            HStack{
//                                NavigationLink(destination: conversation().navigationBarBackButtonHidden()){
//                                    Image(systemName: "person.circle")
//                                        .resizable(resizingMode: .tile)
//                                        .frame(width: 50, height: 50)
//                                        .padding(.trailing, 10)
//                                        .foregroundColor(.primarycolor)
//                                    VStack(alignment: .leading){
//                                        Text("Omar")
//                                            .font(.title2)
//                                            .fontWeight(.bold)
//                                            .foregroundColor(.black)
//                                        Text("Bonjour...")
//                                            .frame(width: 200, height: 50, alignment: .leading)
//                                            .font(.callout)
//                                            .fontWeight(.light)
//                                            .foregroundColor(.gray)
//                                            .padding(.top, -25)
//                                    }
//                                }
//                            }
//                        .offset(x: -45, y:90)
//                            HStack{
//                                NavigationLink(destination: conversation().navigationBarBackButtonHidden()){
//                                    Image(systemName: "person.circle")
//                                        .resizable(resizingMode: .tile)
//                                        .frame(width: 50, height: 50)
//                                        .padding(.trailing, 10)
//                                        .foregroundColor(.primarycolor)
//                                    VStack(alignment: .leading){
//                                        Text("Karim")
//                                            .font(.title2)
//                                            .fontWeight(.bold)
//                                            .foregroundColor(.black)
//                                        Text("salem")
//                                            .frame(width: 200, height: 50, alignment: .leading)
//                                            .font(.callout)
//                                            .fontWeight(.light)
//                                            .foregroundColor(.gray)
//                                            .padding(.top, -25)
//                                    }
//                                }
//                            }
//                        .offset(x: -45, y:90)
                        }
                        .padding(.leading)
                    }
                }
            }
            .navigationTitle("Messages")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(leading:NavigationLink(destination: settings().navigationBarBackButtonHidden(), label: {Image(systemName: "chevron.backward")
                    .font(.title2)
                .foregroundColor(.black)}))
        }
    }
}
#Preview {
    message()
}


