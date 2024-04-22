//
//  forgetpwd.swift
//  medidonate
//
//  Created by fares kassis on 13/3/2024.
//

import SwiftUI

struct forgetpwd1: View {
    @State var mail: String = ""
    var body: some View {
        NavigationView(){
            VStack(alignment: .leading){
                Text("Enter yor email address and we will send you a reset instructions.")
                    .font(.title2)
                    .foregroundColor(Color("gray2"))
                    .padding(.leading)
                    .padding(.top)
                Text("Email Address")
                    .font(.title3)
                    .foregroundColor(Color("gray2"))
                    .padding(.top, 30)
                    .padding(.leading, 15)
                TextField("Write your email here", text: $mail)
                    .font(.callout)
                    .padding(.bottom, 10)
                    .padding(.top, 10)
                    .padding(.leading, 35)
                    .keyboardType(.emailAddress)
                Rectangle()
                    .fill(Color.gray2)
                    .frame(width: 360, height: 2)
                    .offset(x: 20)
                NavigationLink(destination: forgetpwd2().navigationBarBackButtonHidden()){
                        ZStack{
                        Group{
                            Rectangle()
                                .cornerRadius(12)
                                .padding(.all)
                                .foregroundStyle(Color.secondarycolor)
                                .frame(width: 300, height: 100, alignment: .center)
                            Text("Reset Password")
                                .font(.title)
                                .fontWeight(.semibold)
                                .multilineTextAlignment(.center)
                                .foregroundStyle(.white)
                        }
                    }
                    .offset(x: 46)
                }
            }
            .navigationBarItems(leading: NavigationLink(destination: login().navigationBarBackButtonHidden(), label: {Image(systemName: "chevron.backward")
                    .font(.title2)
                .foregroundColor(.black)}))
            .offset(y: -210)
        }
    }
}
    
#Preview {
    forgetpwd1()
}
