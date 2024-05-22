//
//  signup.swift
//  medidonate
//
//  Created by fares kassis on 7/3/2024.
//

import SwiftUI
import Foundation


import Foundation

class RegisterService {
    static var token: String?
    static var userID: Int?
    static var userInfo: UserInfo?

    static func registerrequest(name: String, phone_number: String, email: String, password: String, completion: @escaping (Bool) -> Void) {
        let url = URL(string: "http://localhost:1337/api/auth/local/register")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        let payload: [String: Any] = ["username": name, "email": email, "password": password, "phone": phone_number]
        guard let payloadData = try? JSONSerialization.data(withJSONObject: payload) else {
            print("Error creating payload data")
            completion(false)
            return
        }

        request.httpBody = payloadData
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                completion(false)
                return
            }

            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                print("HTTP status code error")
                completion(false)
                return
            }

            guard let data = data else {
                print("No data received")
                completion(false)
                return
            }

            do {
                if let json = try JSONSerialization.jsonObject(with: data) as? [String: Any],
                   let jwt = json["jwt"] as? String,
                   let user = json["user"] as? [String: Any] {
                    RegisterService.token = jwt
                    let userData = try JSONSerialization.data(withJSONObject: user)
                    RegisterService.userInfo = try JSONDecoder().decode(UserInfo.self, from: userData)
                    RegisterService.userID = RegisterService.userInfo?.id
                    print("Token stored: \(jwt)")
                    print("User Info: \(String(describing: RegisterService.userInfo))")
                    completion(true)
                } else {
                    print("Failed to decode token or user info")
                    completion(false)
                }
            } catch {
                print("JSON decoding error: \(error)")
                completion(false)
            }
        }.resume()
    }
}

struct signup: View {
    @State var name: String = ""
    @State var phone_number: String = ""
    @State var code: String = ""
    @State var email: String = ""
    @State var password: String = ""
    @ObservedObject var viewModel = PostViewModel()



    

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
                VStack(alignment: .center, spacing: 25){
                    TextField("Full Name", text: $name)
                        .frame(width: 330, height: 30)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(25)
                        .shadow(color: .black.opacity(0.2), radius: 5)
                    HStack{
                        TextField("Phone Number", text: $phone_number)
                            .frame(width: 330, height: 30)
                            .font(.system(size: 20))
                            .keyboardType(.phonePad)
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(25)
                    .shadow(color: .black.opacity(0.2), radius: 5)
                    TextField("Email", text: $email)
                        .frame(width: 330, height: 30)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(25)
                        .shadow(color: .black.opacity(0.2), radius: 5)
                        .keyboardType(.emailAddress)
                    SecureField("Password", text: $password)
                        .textContentType(.password)
                        .frame(width: 330, height: 30)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(25)
                        .shadow(color: .black.opacity(0.2), radius: 5)
                        .keyboardType(.asciiCapable)
                    NavigationLink(destination: home().navigationBarBackButtonHidden(true), isActive: $viewModel.showhomescreen) {
                        Button(action: {
                            viewModel.registerUser(name: name, phone: phone_number, email: email, password: password)
                        }, label: {
                            ZStack {
                                Group {
                                    Circle()
                                        .foregroundColor(.secondarycolor)
                                        .frame(width: 64, height: 64)
                                    Image(systemName: "arrowshape.right.fill")
                                        .font(.system(size: 30))
                                        .foregroundColor(.white)
                                }
                            }
                        })
                        .alert(isPresented: $viewModel.showAlert) {
                            Alert(title: Text("Registration"), message: Text(viewModel.alertMessage), dismissButton: .default(Text("OK")))
                        }
                    }
                    .offset(x: 135, y: 30)
                    NavigationLink(destination: login().navigationBarBackButtonHidden()){
                        Text("Already have an account ? Login")
                            .font(.body)
                            .padding(.all, 10)
                            .underline()
                    }
                    .offset(y: 70)
                    .accentColor(.gray)
                }
                .offset(y: 80)
            }
        }
    }
}
#Preview {
    signup()
}
