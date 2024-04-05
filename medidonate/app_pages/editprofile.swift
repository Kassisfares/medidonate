//
//  settings.swift
//  medidonate
//
//  Created by fares kassis on 11/3/2024.
//

import SwiftUI

struct editprofile: View {
    @State var fullname: String = ""
    @State var email: String = ""
    @State var password: String = ""
    @State var code: String = ""
    @State var phonenumber: String = ""
    @State private var DOB = Date()
    @State var gender = "tap to select medicine's name"
    var body: some View {
        NavigationView{
            ScrollView{
                VStack {
                    ZStack{
                        Group{
                            Rectangle()
                                .fill(Color.primarycolor)
                                .frame(width: 400, height: 136)
                            Text("Your profile")
                                .font(.title2)
                                .fontWeight(.regular)
                                .foregroundColor(Color.white)
                                .offset(x: -100, y: 17)
                        }
                    }
                    Image(systemName: "person.circle.fill")
                        .resizable(resizingMode: .tile)
                        .frame(width: 100, height: 100)
                        .foregroundColor(.green)
                    Group{
                        Text("Full Name")
                            .offset(x: -130)
                            .frame(height: 25)
                        ZStack(alignment: .leading){
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.black, lineWidth: 2)
                                .foregroundColor(.white)
                                .frame(width: 365, height: 50)
                                .cornerRadius(10)
                            TextField("fares kassis", text: $fullname)
                                .font(.headline)
                                .frame(width: 300, height: 50)
                                .padding(.leading)
                                .fontWeight(.regular)
                        }
                        Text("Date Of Birth")
                            .offset(x: -120)
                            .frame(height: 25)
                        ZStack{
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.black, lineWidth: 2)
                                .foregroundColor(.white)
                                .frame(width: 365, height: 50)
                                .cornerRadius(10)
                            DatePicker("D.O.B", selection: $DOB, in: ...Date(), displayedComponents:.date)
                                .frame(width: 330)
                        }
                        Text("Phone Number")
                            .offset(x: -110)
                            .frame(height: 25)
                        HStack{
                            Group{
                                ZStack{
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.black, lineWidth: 2)
                                        .foregroundColor(.white)
                                        .frame(width: 50, height: 50, alignment: .center)
                                        .cornerRadius(10)
                                    TextField("+216", text: $code)
                                        .frame(width: 50, height: 30)
                                }
                                ZStack{
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.black, lineWidth: 2)
                                        .foregroundColor(.white)
                                        .frame(width: 305, height: 50, alignment: .leading)
                                        .cornerRadius(10)
                                    TextField("20908696", text: $phonenumber)
                                        .frame(width: 90, height: 30)
                                }
                            }
                        }
                        Text("Email")
                            .offset(x: -145)
                            .frame(height: 25)
                        ZStack(alignment: .leading){
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.black, lineWidth: 2)
                                .foregroundColor(.white)
                                .frame(width: 365, height: 50)
                                .cornerRadius(10)
                            TextField("fareskas123@gmail.com", text: $email)
                                .font(.headline)
                                .frame(width: 300, height: 50)
                                .padding(.leading)
                                .fontWeight(.regular)
                        }
                        Text("Male")
                            .offset(x: -145)
                            .frame(height: 25)
                        ZStack(alignment: .leading){
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.black, lineWidth: 2)
                                .foregroundColor(.white)
                                .frame(width: 365, height: 50)
                                .cornerRadius(10)
                            Menu("\(gender)"){
                                Button("Male"){
                                    gender = "Male"
                                }
                                Button("Female"){
                                    gender = "Female"
                                }
                            }
                            .foregroundColor(.gray)
                            .padding(.leading)
                            .frame(width: 250, alignment: .leading)
                        }
                        Text("Password")
                            .offset(x: -125)
                            .frame(height: 25)
                        ZStack(alignment: .leading){
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.black, lineWidth: 2)
                                .foregroundColor(.white)
                                .frame(width: 365, height: 50)
                                .cornerRadius(10)
                            TextField("***********", text: $password)
                                .font(.headline)
                                .frame(width: 300, height: 50)
                                .padding(.leading)
                                .fontWeight(.regular)
                        }
                        NavigationLink (destination: settings().navigationBarBackButtonHidden(), label:{
                            ZStack{
                                Rectangle()
                                    .cornerRadius(12)
                                    .foregroundStyle(Color.primarycolor)
                                    .frame(width: 250, height: 40, alignment: .center)
                                    .padding()
                                Text("Done")
                                    .font(.title2)
                                    .fontWeight(.medium)
                                    .multilineTextAlignment(.center)
                                    .foregroundStyle(.white)
                            }
                        })
                    }
                }
                .offset(y: -107)
            }
            .navigationBarItems(leading:NavigationLink(destination: settings().navigationBarBackButtonHidden(), label: {Image(systemName: "chevron.backward")
                    .font(.title2)
                .foregroundColor(.white)}))
        }
    }
}
#Preview {
    editprofile()
}


