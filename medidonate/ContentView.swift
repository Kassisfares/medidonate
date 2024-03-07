//
//  ContentView.swift
//  medidonate
//
//  Created by fares kassis on 7/3/2024.
//

import SwiftUI

struct ContentView: View {
    @State var email: String = ""
    @State var password: String = ""
    var body: some View {
        ZStack{
            Group{
                Circle()
                    .fill(Color.primarycolor)
                    .frame(width: 1000, height: 575)
                    .offset(x: -140, y: -480)
                    .rotationEffect(.degrees(10))
                Text("Login")
                    .font(.system(size: 50))
                    .fontWeight(.bold)
                    .foregroundColor(Color.white)
                    .offset(x: -70, y: -310)
                Text("Now!")
                    .font(.system(size: 50))
                    .fontWeight(.bold)
                    .foregroundColor(Color.white)
                    .offset(x: -73, y: -260)
                Image(systemName: "arrowshape.left")
                    .font(.system(size: 30))
                    .foregroundColor(Color.white)
                    .frame(width: 200, height: 200)
                    .offset(x: -160, y: -360)
            }
            VStack(alignment: .center, spacing: 10){
                TextField("Email or Phone", text: $email)
                    .frame(width: 330, height: 50)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(25)
                    .shadow(color: .black.opacity(0.2), radius: 5)
                TextField("Password", text: $password)
                    .frame(width: 330, height: 50)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(25)
                    .shadow(color: .black.opacity(0.2), radius: 5)
                HStack(spacing: 140){
                    Text("Forget Password ?")
                        .font(.body)
                    ZStack{
                        Group {
                            Circle()
                                .foregroundColor(.secondarycolor)
                                .frame(width: 64, height: 64)
                            Image(systemName: "arrowshape.right.fill")
                                .font(.system (size: 30))
                                .foregroundColor(.white)
                        }
                    }
                }
                Text("Or connect with")
                    .font(.callout)
                    .foregroundColor(Color.gray)
                VStack(alignment: .leading){
                    Group{
                        HStack(spacing: 5){
                            Group{
                                Image("google")
                                    .resizable()
                                    .scaledToFill()
                                    .clipped()
                                    .frame(width: 50, height: 50)
                                Text("Continue with google")
                                    .font(.body)
                            }
                        }
                        HStack(spacing: 5){
                            Group{
                                Image("facebook")
                                    .resizable()
                                    .scaledToFill()
                                    .clipped()
                                    .frame(width: 50, height: 50)
                                Text("Continue with facebook")
                                    .font(.body)
                            }
                        }
                        HStack(spacing: 5){
                            Group{
                                Image("apple")
                                    .resizable()
                                    .scaledToFill()
                                    .clipped()
                                    .frame(width: 50, height: 50)
                                Text("Continue with apple")
                                    .font(.body)
                            }
                        }
                    }
                }
            }
        }
    }
}
#Preview {
    ContentView()
}
