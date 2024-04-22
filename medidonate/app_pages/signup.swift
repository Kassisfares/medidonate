//
//  signup.swift
//  medidonate
//
//  Created by fares kassis on 7/3/2024.
//

import SwiftUI
import CountryPicker

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
    @State var isShowPicker: Bool = false
    @State var countryObj: Country?
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
                            Button {
                                isShowPicker = true
                            } label: {
                                if let countryObj = countryObj{
                                    
                                    Text("\( countryObj.isoCode.getFlag() )")
                                        .font(.system(size: 30))
                                        .foregroundColor(.black)
                                    
                                    Text("+\( countryObj.phoneCode )")
                                        .font(.system(size: 20))
                                        .foregroundColor(.black)
                                }
                            }
                            TextField("Phone Number", text: $phone_number)
                                .frame(width: 240, height: 30)
                                .font(.system(size: 20))
                                .keyboardType(.phonePad)
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(25)
                    .shadow(color: .black.opacity(0.2), radius: 5)
                    .border(.red, width: CGFloat(wrongnumber))
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
                            loginuser(name: name, phone_number: phone_number, email: email, password: password, repassword: repassword)
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
        .onAppear{
            self.countryObj = Country(phoneCode: "91", isoCode: "IN")
        }
        .sheet(isPresented: $isShowPicker, content: {
            CountryPickerUI(country: $countryObj)
        })
    }
    func loginuser(name: String, phone_number: String, email: String, password: String, repassword: String) {
        if name.lowercased() == ""{
            wrongname = 2
        }
        else if phone_number.lowercased() == ""{
            wrongnumber = 2
            wrongname = 0
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
