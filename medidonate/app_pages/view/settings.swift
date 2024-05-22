//
//  settings.swift
//  medidonate
//
//  Created by fares kassis on 11/3/2024.
//

import SwiftUI

struct settings: View {
    @State var email: String = ""
    @State var password: String = ""
    @State var showalert: Bool = false
    @State private var navigateToLogin = false

    var body: some View {
        NavigationView{
            VStack {
                ZStack{
                    Group{
                        Rectangle()
                            .fill(Color.primarycolor)
                            .frame(width: 400, height: 220)
                        HStack{
                            Image(systemName: "person.circle.fill")
                                .resizable(resizingMode: .tile)
                                .frame(width: 80, height: 80)
                                .foregroundColor(.green)
                                .offset(y: 30)
                            if let userInfo = AuthService.userInfo ?? RegisterService.userInfo {
                                VStack(alignment: .leading){
                                    Group{
                                        Text("Hello, \(userInfo.username) ")
                                            .font(.title2)
                                            .fontWeight(.bold)
                                            .foregroundStyle(Color.white)
                                        Text("Registered Since Apr 2024")
                                            .font(.headline)
                                            .fontWeight(.medium)
                                            .foregroundStyle(Color.white)
                                    }
                                    .padding(.leading, 5)
                                    .offset(y: 28)
                                }
                            }
                            NavigationLink(destination: editprofile().navigationBarBackButtonHidden()){
                                Image(systemName: "square.and.pencil")
                                    .foregroundColor(.white)
                            }
                            .offset(x:20, y: 25)
                        }
                        .offset(x:-10, y: 20)
                    }
                    .offset(y: -200)
                }
                VStack(alignment: .leading){
                    Group(){
                        NavigationLink(destination: ReceivedRequests().navigationBarBackButtonHidden()){
                            HStack{
                                Image(systemName: "clock.arrow.circlepath")
                                    .padding(.bottom, 10)
                                    .padding(.leading, 20)
                                    .padding(.top, 10)
                                Text("Received Requests")
                                    .font(.title2)
                                    .padding(.bottom, 10)
                                    .padding(.top, 10)
                            }
                            .foregroundColor(.black)
                        }
                        
                        Rectangle()
                            .fill(Color.gray1)
                            .frame(width: 350, height: 2)
                            .offset(x: 8)
                        NavigationLink(destination: message().navigationBarBackButtonHidden()){
                            HStack{
                                Image(systemName: "message")
                                    .padding(.bottom, 10)
                                    .padding(.top, 10)
                                    .padding(.leading, 20)
                                Text("Messages")
                                    .font(.title2)
                                    .padding(.bottom, 10)
                                    .padding(.top, 10)
                            }
                        }
                        .foregroundColor(.black)
                        Rectangle()
                            .fill(Color.gray1)
                            .frame(width: 350, height: 2)
                            .offset(x: 8)
                        NavigationLink(destination: changelocation().navigationBarBackButtonHidden()){
                            HStack{
                                Image(systemName: "location")
                                    .padding(.bottom, 10)
                                    .padding(.top, 10)
                                    .padding(.leading, 20)
                                Text("Your Addresses")
                                    .font(.title2)
                                    .padding(.bottom, 10)
                                    .padding(.top, 10)
                            }
                        }
                        .foregroundColor(.black)
                        Rectangle()
                            .fill(Color.gray1)
                            .frame(width: 350, height: 2)
                            .offset(x: 8)
                        
                        NavigationLink(destination: login().navigationBarBackButtonHidden(), isActive: self.$navigateToLogin) { EmptyView() }
                        Button {
                            showalert = true
                        } label: {
                            HStack{
                                Image(systemName: "power.circle.fill")
                                    .foregroundColor(Color("primarycolor"))
                                    .padding(.bottom, 10)
                                    .padding(.top, 10)
                                    .padding(.leading, 20)
                                Text("Log out")
                                    .font(.title2)
                                    .padding(.bottom, 10)
                                    .padding(.top, 10)
                                    .foregroundColor(.black)
                            }
                        }
                        .alert(isPresented: $showalert, content: {
                            Alert(title: Text("Are you sure you want to Log out ?"),
                                  primaryButton: Alert.Button.destructive(Text("Log out"), action: {
                                self.navigateToLogin = true
                            }),
                                  secondaryButton: Alert.Button.cancel(Text("cancel")))
                            
                        })
                    }
                    Text("Need Help?")
                        .fontWeight(.semibold)
                        .frame(width: 330, height: 25)
                        .padding()
                        .background(Color.helpcolor)
                        .cornerRadius(25)
                        .shadow(color: .black.opacity(0.2), radius: 5)
                }
                .offset(y: -200)
            }
            .navigationBarItems(leading:NavigationLink(destination: home().navigationBarBackButtonHidden(), label: {Image(systemName: "chevron.backward")
                    .font(.title2)
                    .foregroundColor(.white)}))
        }
    }
}
#Preview {
    settings()
}


