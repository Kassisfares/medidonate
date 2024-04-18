//
//  signup.swift
//  medidonate
//
//  Created by fares kassis on 7/3/2024.
//

import SwiftUI

struct signup: View {
    @State var name: String = ""
    @State var phone_number: String = ""
    @State var code: String = ""
    @State var email: String = ""
    @State var password: String = ""
    @State var repassword: String = ""
    @State private var selectadate = Date()
    var body: some View {
        NavigationView{
            ZStack{
                Group{
                    Circle()
                        .fill(Color.primarycolor)
                        .frame(width: 1000, height: 575)
                        .offset(x: -140, y: -480)
                        .rotationEffect(.degrees(10))
                    Text("Create")
                        .font(.system(size: 50))
                        .fontWeight(.bold)
                        .foregroundColor(Color.white)
                        .offset(x: -70, y: -310)
                    Text("Account")
                        .font(.system(size: 50))
                        .fontWeight(.bold)
                        .foregroundColor(Color.white)
                        .offset(x: -47, y: -260)
                }
                VStack(alignment: .center, spacing: 10){
                    Spacer()
                    TextField("Full Name", text: $name)
                        .frame(width: 330, height: 30)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(25)
                        .shadow(color: .black.opacity(0.2), radius: 5)
                    ZStack{
                        Rectangle()
                            .foregroundColor(.white)
                            .frame(width: 365, height: 50)
                            .cornerRadius(20)
                            .shadow(color: .black.opacity(0.2), radius: 5)
                        DatePicker("D.O.B", selection: $selectadate, in: ...Date(), displayedComponents:.date)
                            .frame(width: 330)
                    }
                    HStack{
                        Group{
                            TextField("+000", text: $code)
                                .frame(width: 50, height: 30)
                            TextField("Phone Number", text: $phone_number)
                                .frame(width: 240, height: 30)
                        }
                        .padding()
                        .background(Color.white)
                        .cornerRadius(25)
                        .shadow(color: .black.opacity(0.2), radius: 5)
                    }
                    TextField("Email", text: $email)
                        .frame(width: 330, height: 30)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(25)
                        .shadow(color: .black.opacity(0.2), radius: 5)
                    TextField("Password", text: $password)
                        .textContentType(.password)
                        .frame(width: 330, height: 30)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(25)
                        .shadow(color: .black.opacity(0.2), radius: 5)
                    TextField("Retype Password", text: $repassword)
                        .textContentType(.password)
                        .frame(width: 330, height: 30)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(25)
                        .shadow(color: .black.opacity(0.2), radius: 5)
                    NavigationLink(destination: home().navigationBarBackButtonHidden()){
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
                    .padding(.all, 10)
                    .offset(x: 130)
                    NavigationLink(destination: login().navigationBarBackButtonHidden()){
                        Text("Already have an account ? Login")
                            .font(.body)
                            .padding(.all, 10)
                            .underline()
                    }
                    .accentColor(.gray)
                }
            }
        }
    }
}
#Preview {
    signup()
}
