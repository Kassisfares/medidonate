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
                        .offset(x: -50, y: -260)
                    Image(systemName: "arrowshape.left")
                        .font(.system(size: 30))
                        .foregroundColor(Color.white)
                        .frame(width: 200, height: 200)
                        .offset(x: -160, y: -360)
                }
                VStack(alignment: .center, spacing: 10){
                    Spacer()
                    TextField("Full Name", text: $name)
                        .frame(width: 330, height: 30)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(25)
                        .shadow(color: .black.opacity(0.2), radius: 5)
                        .padding(.bottom, 5)
                    DatePicker("D.O.B", selection: $selectadate, in: ...Date(), displayedComponents:.date)
                        .padding(.bottom, 5)
                    HStack{
                        Group{
                            TextField("+000", text: $phone_number)
                                .frame(width: 50, height: 30)
                            TextField("Phone Number", text: $phone_number)
                                .frame(width: 240, height: 30)
                        }
                        .padding()
                        .background(Color.white)
                        .cornerRadius(25)
                        .shadow(color: .black.opacity(0.2), radius: 5)
                        .padding(.bottom, 5)
                    }
                    TextField("Email", text: $email)
                        .frame(width: 330, height: 30)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(25)
                        .shadow(color: .black.opacity(0.2), radius: 5)
                        .padding(.bottom, 5)
                    TextField("Password", text: $password)
                        .frame(width: 330, height: 30)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(25)
                        .shadow(color: .black.opacity(0.2), radius: 5)
                        .padding(.bottom, 5)
                    TextField("Retype Password", text: $repassword)
                        .frame(width: 330, height: 30)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(25)
                        .shadow(color: .black.opacity(0.2), radius: 5)
                        .padding(.bottom, 5)
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
                            .padding(.all, 10)
                            .offset(x: 130)
                        }
                    }
                    Text("Already have an account ? Sign in")
                        .font(.body)
                        .padding(.all, 10)
                        .underline()
                }
            }
        }
    }
}
#Preview {
    signup()
}
