//
//  ContentView.swift
//  medidonate
//
//  Created by fares kassis on 7/3/2024.
//

import SwiftUI

import Foundation

struct UserInfo: Decodable {
    let id: Int
    let username: String
    let email: String
    let provider: String
    let confirmed: Bool
    let blocked: Bool
    let createdAt: String
    let updatedAt: String
    let phone: String?
}

class AuthService {
    static var token: String?
    static var userID: Int?
    static var userInfo: UserInfo?

    

    static func loginrequest(email: String, password: String, completion: @escaping (Bool) -> Void) {
            let url = URL(string: "http://localhost:1337/api/auth/local")!
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            
            let payload: [String: Any] = ["identifier": email, "password": password]
            guard let payloadData = try? JSONSerialization.data(withJSONObject: payload) else {
                print("Error creating payload data")
                completion(false)
                return
            }
            
            request.httpBody = payloadData
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    print("Error: \(error)")
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
                    print("No data")
                    completion(false)
                    return
                }
                
                do {
                    if let json = try JSONSerialization.jsonObject(with: data) as? [String: Any],
                       let jwt = json["jwt"] as? String,
                       let user = json["user"] as? [String: Any] {
                        AuthService.token = jwt
                        let userData = try JSONSerialization.data(withJSONObject: user)
                        AuthService.userInfo = try JSONDecoder().decode(UserInfo.self, from: userData)
                        AuthService.userID = AuthService.userInfo?.id
                        print("Token stored: \(jwt)")
                        print("User Info: \(String(describing: AuthService.userInfo))")
                        completion(true)
                    } else {
                        print("Failed to decode token or user info")
                        completion(false)
                    }
                } catch {
                    print("JSON decoding error: \(error)")
                    completion(false)
                }
            }
            task.resume()
        }
}






struct login: View {
    @State var email: String = ""
    @State var password: String = ""
    @State private var wrongemail = 0
    @State private var wrongpassword = 0
    @State private var showhomescreen = false
    @State private var navigateToHome = false
    @State private var verifLigin = false
    @State private var loginSuccess = false
    @State private var showAlert = false
    @State private var alertMessage = ""
    @ObservedObject var viewModel = PostViewModel()

    var body: some View {
        NavigationView(){
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
                VStack(spacing: 14){
                    Spacer()
                    TextField("Email or Phone", text: $email)
                        .frame(width: 330, height: 50)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(25)
                        .shadow(color: .black.opacity(0.2), radius: 5)
                        .border(.red, width: CGFloat(wrongemail))
                        .keyboardType(.emailAddress)
                    SecureField("Password", text: $password)
                        .frame(width: 330, height: 50)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(25)
                        .shadow(color: .black.opacity(0.2), radius: 5)
                        .border(.red, width: CGFloat(wrongpassword))
                    HStack(spacing: 140){
                        NavigationLink(destination: forgetpwd1().navigationBarBackButtonHidden()){
                            Text("Forget Password ?")
                                .font(.body)
                                .padding(.all, 5)
                                .padding(.leading)
                        }
                        .accentColor(.black)
                        NavigationLink(destination: home().navigationBarBackButtonHidden(), isActive: $viewModel.showhomescreen) {
                            Button(action: {
                                viewModel.loginAndFetchUser(email: email, password: password)
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
                                    .padding(.trailing)
                                }
                            })
                            .alert(isPresented: $viewModel.showAlert) {
                                Alert(title: Text("Login"), message: Text(viewModel.alertMessage), dismissButton: .default(Text("OK")))
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
                    NavigationLink(destination: signup().navigationBarBackButtonHidden()){
                        Text("Need an account ? Register Now!")
                            .font(.body)
                            .padding()
                            .underline()
                        
                    }
                    .accentColor(.gray)
                }
            }
        }
    }
    
    func loginuser(email: String, password: String) {
        if email.lowercased() == ""{
            wrongemail = 2
            verifLigin = true
        }
        else if password.lowercased() == ""{
            wrongpassword = 2
            wrongemail = 0
            verifLigin = true
        }
        else {
            wrongemail = 0
            wrongpassword = 0
            showhomescreen = true
        }
    }
}
#Preview {
    login()
}
