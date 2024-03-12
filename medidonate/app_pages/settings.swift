//
//  settings.swift
//  medidonate
//
//  Created by fares kassis on 11/3/2024.
//

import SwiftUI

struct settings: View {
    @State var email: String = ""
    @State var password: String = ""
    var body: some View {
        //Text("hello")
        VStack {
            ZStack{
                Group{
                    Rectangle()
                        .fill(Color.primarycolor)
                        .frame(width: 400, height: 220)
                    HStack{
                        Circle()
                            .frame(width: 100, height: 100)
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
                            .padding(.leading, 10)
                            .offset(y: 28)
                        }
                    }
                }
                .offset(y: -200)
            }
            VStack(alignment: .leading){
                Group(){
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
                    Rectangle()
                        .fill(Color.gray1)
                        .frame(width: 350, height: 2)
                        .offset(x: 8)
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
                    Rectangle()
                        .fill(Color.gray1)
                        .frame(width: 350, height: 2)
                        .offset(x: 8)
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
                    Rectangle()
                        .fill(Color.gray1)
                        .frame(width: 350, height: 2)
                        .offset(x: 8)
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
                Text("Need Help?")
                    .fontWeight(.semibold)
                    .frame(width: 330, height: 25)
                    .padding()
                    .background(Color.helpcolor)
                    .cornerRadius(25)
                    .shadow(color: .black.opacity(0.2), radius: 5)
            }
            .offset(y: -200)
        }
    }
}
#Preview {
    settings()
}


