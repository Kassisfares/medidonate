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
    @State private var wrongname = 0
    @State private var wrongnumber = 0
    @State private var wrongcode = 0
    @State private var wrongemail = 0
    @State private var wrongpassword = 0
    @State private var wrongRepassword = 0
    @State private var showhomescreen1 = false
    @State private var navigateToHome = false
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
                        .border(.red, width: CGFloat(wrongname))
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
                                .border(.red, width: CGFloat(wrongcode))
                                .keyboardType(.phonePad)
                            TextField("Phone Number", text: $phone_number)
                                .frame(width: 240, height: 30)
                                .border(.red, width: CGFloat(wrongnumber))
                                .keyboardType(.phonePad)
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
                        .border(.red, width: CGFloat(wrongemail))
                        .keyboardType(.emailAddress)
                    SecureField("Password", text: $password)
                        .textContentType(.password)
                        .frame(width: 330, height: 30)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(25)
                        .shadow(color: .black.opacity(0.2), radius: 5)
                        .border(.red, width: CGFloat(wrongpassword))
                        .keyboardType(.asciiCapable)
                    SecureField("Retype Password", text: $repassword)
                        .textContentType(.password)
                        .frame(width: 330, height: 30)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(25)
                        .shadow(color: .black.opacity(0.2), radius: 5)
                        .border(.red, width: CGFloat(wrongRepassword))
                    NavigationLink(destination: home().navigationBarBackButtonHidden(), isActive: $showhomescreen1) {
                        Button(action: {
                            loginuser(name: name, code: code, phone_number: phone_number, email: email, password: password, repassword: repassword)
                        }, label: {
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
                        })
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
    func loginuser(name: String, code: String, phone_number: String, email: String, password: String, repassword: String) {
        if name.lowercased() == ""{
            wrongname = 2
        }
        else if code.lowercased() == ""{
            wrongcode = 2
            wrongname = 0
        }
        else if phone_number.lowercased() == ""{
            wrongnumber = 2
            wrongcode = 0
        }
        else if email.lowercased() == ""{
            wrongemail = 2
            wrongnumber = 0
        }
        else if password.lowercased() == ""{
            wrongpassword = 2
            wrongemail = 0
        }
        else if repassword.lowercased() == ""{
            wrongRepassword = 2
            wrongpassword = 0
        }
        else {
            wrongname = 0
            wrongcode = 0
            wrongnumber = 0
            wrongemail = 0
            wrongpassword = 0
            wrongRepassword = 0
            showhomescreen1 = true
        }
    }
}
#Preview {
    signup()
}
