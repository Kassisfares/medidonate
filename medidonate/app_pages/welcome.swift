//
//  signup.swift
//  medidonate
//
//  Created by fares kassis on 7/3/2024.
//

import SwiftUI

struct welcome: View {
    @State var search: String = ""
    var body: some View {
        NavigationView{
            VStack {
                ZStack{
                    Circle()
                        .fill(Color.primarycolor)
                        .frame(width: 500, height: 775)
                        .offset(y: -90)
                    VStack{
                        Image("welcome")
                            .resizable()
                            .frame(width: 250, height: 250)
                            .padding(.bottom, -55)
                        Text("Medi_Donate")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(Color.white)
                    }
                }
                .offset(y: -200)
                VStack {
                    NavigationLink(destination: login() .navigationBarBackButtonHidden(true)){
                        ZStack{
                            Group {
                                RoundedRectangle(cornerRadius: 30)
                                    .foregroundColor(.secondarycolor)
                                    .frame(width: 250, height: 50)
                                Text("Login")
                                    .font(.title)
                                    .foregroundColor(.white)
                            }
                        }
                    }
                    .padding(.bottom, 30)
                    NavigationLink(destination: signup() .navigationBarBackButtonHidden(true)){
                        ZStack{
                            Group {
                                RoundedRectangle(cornerRadius: 30)
                                    .foregroundColor(.secondarycolor)
                                    .frame(width: 250, height: 50)
                                Text("Sign Up")
                                    .font(.title)
                                    .foregroundColor(.white)
                            }
                        }
                    }
                }
                .offset(y: -300)
            }
        }
    }
}
#Preview {
    welcome()
}
