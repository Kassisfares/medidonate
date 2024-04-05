//
//  settings.swift
//  medidonate
//
//  Created by fares kassis on 11/3/2024.
//

import SwiftUI

struct changelocation: View {
    @State var email: String = ""
    @State var password: String = ""
    var body: some View {
        NavigationView{
            VStack {
                ZStack{
                    Group{
                        Rectangle()
                            .fill(Color.primarycolor)
                            .frame(width: 400, height: 220)
                        HStack{
                            Image(systemName: "person.circle.fill")
                                .resizable(resizingMode: .tile)
                                .frame(width: 80, height: 80)
                                .foregroundColor(.green)
                                .offset(y: 30)
                            VStack(alignment: .leading){
                                Group{
                                    Text("Hello, Fares!")
                                        .font(.title2)
                                        .fontWeight(.bold)
                                        .foregroundStyle(Color.white)
                                    Text("Registered Since Feb 2024")
                                        .font(.headline)
                                        .fontWeight(.medium)
                                        .foregroundStyle(Color.white)
                                }
                                .padding(.leading, 5)
                                .offset(y: 28)
                            }
                            NavigationLink(destination: historyrequest().navigationBarBackButtonHidden()){
                                Image(systemName: "square.and.pencil")
                                    .foregroundColor(.white)
                            }
                            .offset(x:20, y: 25)
                        }
                        .offset(x:-10, y: 20)
                    }
                    .offset(y: -140)
                }
                ZStack {
                    VStack(alignment: .leading){
                        Group(){
                            NavigationLink(destination: historyrequest().navigationBarBackButtonHidden()){
                                HStack{
                                    Image(systemName: "clock.arrow.circlepath")
                                        .padding(.bottom, 10)
                                        .padding(.leading, 20)
                                        .padding(.top, 10)
                                    Text("History")
                                        .font(.title2)
                                        .padding(.bottom, 10)
                                        .padding(.top, 10)
                                }
                            }
                            .foregroundColor(.black)
                            Rectangle()
                                .fill(Color.gray1)
                                .frame(width: 350, height: 2)
                                .offset(x: 8)
                            NavigationLink(destination: login().navigationBarBackButtonHidden()){
                                HStack{
                                    Image(systemName: "message")
                                        .padding(.bottom, 10)
                                        .padding(.top, 10)
                                        .padding(.leading, 20)
                                    Text("Messages")
                                        .font(.title2)
                                        .padding(.bottom, 10)
                                        .padding(.top, 10)
                                }
                            }
                            .foregroundColor(.black)
                            Rectangle()
                                .fill(Color.gray1)
                                .frame(width: 350, height: 2)
                                .offset(x: 8)
                            NavigationLink(destination: login().navigationBarBackButtonHidden()){
                                HStack{
                                    Image(systemName: "location")
                                        .padding(.bottom, 10)
                                        .padding(.top, 10)
                                        .padding(.leading, 20)
                                    Text("Your Addresses")
                                        .font(.title2)
                                        .padding(.bottom, 10)
                                        .padding(.top, 10)
                                }
                            }
                            .foregroundColor(.black)
                            Rectangle()
                                .fill(Color.gray1)
                                .frame(width: 350, height: 2)
                                .offset(x: 8)
                            NavigationLink(destination: login().navigationBarBackButtonHidden()){
                                HStack{
                                    Image(systemName: "power.circle.fill")
                                        .foregroundColor(Color("primarycolor"))
                                        .padding(.bottom, 10)
                                        .padding(.top, 10)
                                        .padding(.leading, 20)
                                    Text("Log out")
                                        .font(.title2)
                                        .padding(.bottom, 10)
                                        .padding(.top, 10)
                                }
                            }
                            .foregroundColor(.black)
                        }
                        Text("Need Help?")
                            .fontWeight(.semibold)
                            .frame(width: 330, height: 25)
                            .padding()
                            .background(Color.helpcolor)
                            .cornerRadius(25)
                            .shadow(color: .black.opacity(0.2), radius: 5)
                    }
                    .offset(y: -200)
                    ZStack{
                        Rectangle()
                            .frame(width: 400, height: 430)
                            .foregroundColor(.primarycolor)
                            .cornerRadius(50)
                        VStack{
                            Text("Choose location")
                                .font(.title)
                                .foregroundColor(.white)
                            Text("Set location on map")
                                .font(.title3)
                                .foregroundColor(.white)
                                .offset(x: -90)
                                .padding(.bottom, 10)
                            NavigationLink (destination: changelocation2().navigationBarBackButtonHidden(), label:{
                                Image("map")
                                    .resizable(resizingMode: .stretch)
                                    .frame(width: 300, height: 200)
                            })
                            HStack{
                                Rectangle()
                                    .fill(Color.gray3)
                                    .frame(width:100, height: 2)
                                    .offset(y: -2)
                                Text("Or")
                                    .foregroundColor(.white)
                                    .padding(.leading)
                                    .padding(.trailing)
                                Rectangle()
                                    .fill(Color.gray3)
                                    .frame(width:100, height: 2)
                                    .offset(y: -2)
                            }
                            .padding(.top, 10)
                            .padding(.bottom, 10)
                            NavigationLink (destination: changelocation2().navigationBarBackButtonHidden(), label:{
                                ZStack{
                                    Rectangle()
                                        .cornerRadius(12)
                                        .foregroundStyle(Color.white)
                                        .frame(width: 250, height: 40, alignment: .center)
                                    HStack{
                                        Image(systemName: "plus")
                                            .foregroundColor(.primarycolor)
                                            .fontWeight(.medium)
                                        Text("Add new location")
                                            .font(.title2)
                                            .fontWeight(.medium)
                                            .multilineTextAlignment(.center)
                                            .foregroundStyle(.primarycolor)
                                    }
                                }
                            })
                        }
                    }
                    .offset(y: 70)
                }
            }
            .navigationBarItems(leading:NavigationLink(destination: settings().navigationBarBackButtonHidden(), label: {Image(systemName: "chevron.backward")
                    .font(.title2)
                    .foregroundColor(.white)}))
        }
    }
}
#Preview {
    changelocation()
}


