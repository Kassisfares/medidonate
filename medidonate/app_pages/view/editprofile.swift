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
    @State var phonenumber: String = ""
    @State var showAlert = false
    @State var alertMessage = ""
    
    var body: some View {
        NavigationView{
            ScrollView{
                VStack(spacing: 15){
                    Image(systemName: "person.circle.fill")
                        .resizable(resizingMode: .tile)
                        .frame(width: 100, height: 100)
                        .foregroundColor(.green)
                        .padding(.top)
                    Text("Full Name")
                        .offset(x: -130)
                        .frame(height: 25)
                    ZStack(alignment: .leading){
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.black, lineWidth: 2)
                            .foregroundColor(.white)
                            .frame(width: 365, height: 50)
                            .cornerRadius(10)
                        TextField("", text: $fullname)
                            .font(.headline)
                            .frame(width: 300, height: 50)
                            .padding(.leading)
                            .fontWeight(.regular)
                    }
                    Text("Phone Number")
                        .offset(x: -110)
                        .frame(height: 25)
                    HStack{
                        Group{
                            ZStack(alignment: Alignment(horizontal: .leading, vertical: .center)){
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.black, lineWidth: 2)
                                    .foregroundColor(.white)
                                    .frame(width: 365, height: 50, alignment: .leading)
                                    .cornerRadius(10)
                                TextField("Add your phone number", text: $phonenumber)
                                    .frame(width: 200, height: 30, alignment: .leading)
                                    .padding(.leading)
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
                        TextField("", text: $email)
                            .font(.headline)
                            .frame(width: 300, height: 50)
                            .padding(.leading)
                            .fontWeight(.regular)
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
                            .offset(y: 5)
                    }
                    Button(action: {
                        updateUserProfile()
                    }) {
                        ZStack{
                            Rectangle()
                                .cornerRadius(12)
                                .foregroundStyle(Color.primarycolor)
                                .frame(width: 250, height: 50, alignment: .center)
                                .padding()
                            Text("Save")
                                .font(.title2)
                                .fontWeight(.medium)
                                .multilineTextAlignment(.center)
                                .foregroundStyle(.white)
                        }
                    }
                    .offset(y: 60)
                    .alert(isPresented: $showAlert) {
                        Alert(title: Text("Profile Update"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
                    }
                }
            }
            .navigationTitle("Profile")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(leading:NavigationLink(destination: settings().navigationBarBackButtonHidden(), label: {Image(systemName: "chevron.backward")
                    .font(.title2)
                .foregroundColor(.black)}))
            .onAppear {
                loadUserProfile()
            }
        }
    }
    private func loadUserProfile() {
        if let userInfo = AuthService.userInfo ?? RegisterService.userInfo {
                fullname = userInfo.username
                email = userInfo.email
                phonenumber = userInfo.phone ?? ""
                // Note: Do not prefill the password field for security reasons
            }
        }
    private func updateUserProfile() {
            AuthService.updateUserProfile(fullname: fullname, email: email, phonenumber: phonenumber, password: password) { success, message in
                if success {
                    alertMessage = "Profile updated successfully!"
                } else {
                    alertMessage = message ?? "Failed to update profile."
                }
                showAlert = true
            }
        }
}
#Preview {
    editprofile()
}


