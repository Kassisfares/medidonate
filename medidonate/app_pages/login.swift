//
//  ContentView.swift
//  medidonate
//
//  Created by fares kassis on 7/3/2024.
//

import SwiftUI

struct login: View {
    @State var email: String = ""
    @State var password: String = ""
    var body: some View {
            ZStack{
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
                VStack(spacing: 5){
                    Spacer()
                    TextField("Email or Phone", text: $email)
                        .frame(width: 330, height: 50)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(25)
                        .shadow(color: .black.opacity(0.2), radius: 5)
                        .padding(.bottom, 15)
                    TextField("Password", text: $password)
                        .frame(width: 330, height: 50)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(25)
                        .shadow(color: .black.opacity(0.2), radius: 5)
                        .padding(.bottom, 15)
                    HStack(spacing: 140){
                            Text("Forget Password ?")
                                .font(.body)
                                .padding(.all, 5)
                        Button(action: {
                            // Handle sign-in logic here
                        }) {
                            ZStack{
                                Group {
                                    Circle()
                                        .foregroundColor(.secondarycolor)
                                        .frame(width: 64, height: 64)
                                    Image(systemName: "arrowshape.right.fill")
                                        .font(.system (size: 30))
                                        .foregroundColor(.white)
                                }
                                .padding(.all, 5)
                            }
                        }
                    }
                    Text("Or connect with")
                        .font(.callout)
                        .foregroundColor(Color.gray)
                        .padding(.all, 5)
                    VStack(alignment: .leading){
                            HStack(spacing: 5){
                                Group{
                                    Image("google")
                                        .resizable()
                                        .scaledToFill()
                                        .clipped()
                                        .frame(width: 50, height: 50)
                                    Text("Continue with google")
                                        .font(.title3)
                                }
                                .padding(.bottom, 5)
                            }
                            HStack(spacing: 5){
                                Group{
                                    Image("facebook")
                                        .resizable()
                                        .scaledToFill()
                                        .clipped()
                                        .frame(width: 50, height: 50)
                                    Text("Continue with facebook")
                                        .font(.title3)
                                }
                                .padding(.bottom, 5)
                            }
                            HStack(spacing: 5){
                                Group{
                                    Image("apple")
                                        .resizable()
                                        .scaledToFill()
                                        .clipped()
                                        .frame(width: 50, height: 50)
                                    Text("Continue with apple")
                                        .font(.title3)
                                }
                                .padding(.bottom, 5)
                    }
                        
                }
                    Text("Need an account ? Register Now!")
                        .font(.body)
                        .padding()
                        .underline()
            }
        }
    }
}
#Preview {
    login()
}
