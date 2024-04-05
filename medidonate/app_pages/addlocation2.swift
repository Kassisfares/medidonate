//
//  home.swift
//  medidonate
//
//  Created by fares kassis on 21/3/2024.
//

import SwiftUI
struct addlocation2: View {
    @State var text: String = ""
    var body: some View {
        NavigationView{
            ScrollView{
                VStack(alignment: .leading){
                    HStack{
                        Group{
                            NavigationLink (destination: home().navigationBarBackButtonHidden(), label: {
                                Image(systemName: "plus")
                                    .padding(.leading, 20)
                                    .font(.title)
                                    .rotationEffect(.degrees(45))
                                    .offset(x: 5, y: -6)
                                    .foregroundColor(.black)
                            })
                            Text("Create post")
                                .fontWeight(.semibold)
                                .font(.title2)
                                .foregroundColor(.black)
                                .offset(x: -5)
                            ZStack{
                                Rectangle()
                                    .cornerRadius(12)
                                    .foregroundStyle(Color.primarycolor)
                                    .frame(width: 65, height: 40, alignment: .center)
                                Text("Post")
                                    .font(.title2)
                                    .fontWeight(.semibold)
                                    .multilineTextAlignment(.center)
                                    .foregroundStyle(.white)
                            }
                            .padding(.trailing, 50)
                        }
                        .frame(width: 170, height: 50)
                    }
                    HStack(spacing: -8){
                        Image(systemName: "person.circle.fill")
                            .resizable(resizingMode: .tile)
                            .frame(width: 50, height: 50)
                            .padding(.leading, 80)
                            .foregroundColor(.green)
                        VStack(alignment: .leading){
                            Text("Freas Kassis")
                                .font(.title3)
                                .fontWeight(.semibold)
                            HStack{
                                NavigationLink (destination: home().navigationBarBackButtonHidden(), label:{
                                    ZStack{
                                        RoundedRectangle(cornerRadius: 30)
                                            .stroke(Color.primarycolor, lineWidth: 1)
                                            .foregroundStyle(Color.white)
                                            .frame(width: 75, height: 40, alignment: .center)
                                        Text("Request")
                                            .multilineTextAlignment(.center)
                                            .foregroundStyle(.primarycolor)
                                    }
                                })
                                NavigationLink (destination: home().navigationBarBackButtonHidden(), label:{
                                    ZStack{
                                        RoundedRectangle(cornerRadius: 30)
                                            .stroke(Color.primarycolor, lineWidth: 1)
                                            .foregroundStyle(Color.white)
                                            .frame(width: 75, height: 40, alignment: .center)
                                        Text("Donate")
                                            .multilineTextAlignment(.center)
                                            .foregroundStyle(.primarycolor)
                                    }
                                })
                            }
                        }
                        .frame(width: 200, height: 60)
                        .padding(.leading, 8)
                    }
                    .padding(.top)
                    TextField("What's on your mind ?", text: $text)
                        .font(.title2)
                        .frame(width: 300, height: 50)
                        .background(Color.white)
                        .padding(.leading, 85)
                        .padding(.top)
                }
                HStack(spacing: 20){
                    Image("panadol")
                        .resizable(resizingMode: .stretch)
                        .frame(width: 90, height: 110)
                    VStack(alignment: .leading){
                        Text("Panadole 500mg")
                            .font(.title3)
                            .fontWeight(.regular)
                    }
                    .frame(width: 200, height: 100, alignment: .topLeading)
                }
                .padding(.leading, -30)
                .padding(.bottom, 30)
                ZStack{
                    Rectangle()
                        .frame(width: 400, height: 430)
                        .foregroundColor(.primarycolor)
                        .cornerRadius(50)
                    VStack{
                        Text("Location confirmed")
                            .font(.title)
                            .foregroundColor(.white)
                        Image("map")
                            .resizable(resizingMode: .stretch)
                            .frame(width: 300, height: 230)
                        NavigationLink (destination: addlocation3().navigationBarBackButtonHidden(), label:{
                            ZStack{
                                Rectangle()
                                    .cornerRadius(12)
                                    .foregroundStyle(Color.white)
                                    .frame(width: 250, height: 40, alignment: .center)
                                    .padding()
                                Text("Done")
                                    .font(.title2)
                                    .fontWeight(.medium)
                                    .multilineTextAlignment(.center)
                                    .foregroundStyle(.primarycolor)
                            }
                        })
                    }
                }
            }
        }
    }
}
#Preview {
    addlocation2()
}
