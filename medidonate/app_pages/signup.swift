//
//  signup.swift
//  medidonate
//
//  Created by fares kassis on 7/3/2024.
//

import SwiftUI
import Foundation

func registerrequest(name: String, phone_number: String, email: String, password: String, repassword: String, completion: @escaping (Bool) -> Void) {
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

        if let httpResponse = response as? HTTPURLResponse, !(200...299).contains(httpResponse.statusCode) {
            print("HTTP status code not in the 200-299 range")
            completion(false)
        } else {
            completion(true)
        }
    }.resume()
}


struct signup: View {
    @State var name: String = ""
    @State var phone_number: String = ""
    @State var code: String = ""
    @State var email: String = ""
    @State var password: String = ""
    @State var repassword: String = ""
//    @State private var selectadate: Date = Date()
//    @State private var wrongdate = 0
    @State private var wrongname = 0
    @State private var wrongnumber = 0
    @State private var wrongcode = 0
    @State private var wrongemail = 0
    @State private var wrongpassword = 0
    @State private var wrongRepassword = 0
    @State private var showhomescreen1 = false
    @State private var navigateToHome = false
    @State var isShowPicker: Bool = false
    @State var alertpassword = false
    @State var alertrepassword = false
    @State var alertserver = false

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
                        .border(.red, width: CGFloat(wrongname))
//                    ZStack{
//                        Rectangle()
//                            .foregroundColor(.white)
//                            .frame(width: 360, height: 65)
//                            .cornerRadius(20)
//                            .shadow(color: .black.opacity(0.2), radius: 5)
//                        DatePicker("D.O.B", selection: $selectadate, in: ...Date(), displayedComponents:.date)
//                            .frame(width: 320)
//                    }
//                    .border(.red, width: CGFloat(wrongdate))
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
                    
                        Button(action: {
                            regiteruser(name: name, phone_number: phone_number, email: email, password: password, repassword: repassword)
                            
                            registerrequest(name: name, phone_number: phone_number, email: email, password: password, repassword: repassword) { success in
                                    DispatchQueue.main.async {
                                        if success {
                                            self.showhomescreen1 = true
                                            NavigationLink(destination: home().navigationBarBackButtonHidden(), isActive: $showhomescreen1) {EmptyView()}
                                        }
                                        else {
                                            // Handle the failure, show an alert or error message if needed
                                            self.alertserver = true
                                            }
                                            }
                                        }
                            
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
                    .padding(.all, 10)
                    .offset(x: 130)
                    .alert("Password must be at least 8 characters and include at least one [A..Z], one [a..z], one [0..1], and one special character.", isPresented: $alertpassword) {
                                Button("OK", role: .cancel) {}
                            }
                    .alert("Re-password should be the same password you entred", isPresented: $alertrepassword) {
                                Button("OK", role: .cancel) {}
                            }
                    .alert("error server", isPresented: $alertserver) {
                                Button("OK", role: .cancel) {}
                            }
                    
                    NavigationLink(destination: login().navigationBarBackButtonHidden()){
                        Text("Already have an account ? Login")
                            .font(.body)
                            .padding(.all, 10)
                            .underline()
                    }
                    .offset(y: -15)
                    .accentColor(.gray)
                }
                .offset(y: 110)
            }
        }
    }
    func regiteruser(name: String, phone_number: String, email: String, password: String, repassword: String) {
        
        if name.lowercased() == ""{
            wrongname = 2
        }
        else if phone_number == "" || phone_number.count != 8{
            wrongnumber = 2
            wrongname = 0
        }
        else if !isValidEmail(email){
            wrongemail = 2
            wrongnumber = 0
        }
        else if !isValidPassword(password){
            wrongpassword = 2
            wrongemail = 0
            alertpassword = true
        }
        else if repassword.isEmpty || password != repassword{
            wrongRepassword = 2
            wrongpassword = 0
            alertrepassword = true
        }
        else {
            resetErrors()
            showhomescreen1 = true
        }
    }
    // Email validation check
        func isValidEmail(_ email: String) -> Bool {
            let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Z0-9a-z.-]+\\.[A-Za-z]{2,64}"
            let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
            return emailPred.evaluate(with: email)
        }
    // Password validation check
        func isValidPassword(_ password: String) -> Bool {
            // Passwords must be at least 8 characters, and include at least one uppercase letter, one lowercase letter, one number, and one special character
            let passwordRegEx = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[$@$!%*?&._])[A-Za-z\\d$@$!%*?&._]{8,}"
            let passwordPred = NSPredicate(format: "SELF MATCHES %@", passwordRegEx)
            return passwordPred.evaluate(with: password)
        }
    private func resetErrors() {
            wrongname = 0
            wrongnumber = 0
            wrongemail = 0
            wrongpassword = 0
            wrongRepassword = 0
            alertrepassword = false
            showhomescreen1 = false
        }
}
#Preview {
    signup()
}
