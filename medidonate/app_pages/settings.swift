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
    var body: some View {
        //Text("hello")
        VStack {
            ZStack{
                Group{
                    Rectangle()
                        .fill(Color.blue)
                        .frame(width: 400, height: 220)
                    HStack{
                        Circle()
                            .frame(width: 100, height: 100)
                            .offset(y: 30)
                        VStack(alignment: .leading){
                            Group{
                                Text("Hello, Fares!")
                                    .font(.title2)
                                    .fontWeight(.bold)
                                    .foregroundStyle(Color.white)
                                Text("Registered Since Feb 2024")
                                    .font(.headline)
                                    .fontWeight(.medium)
                                    .foregroundStyle(Color.white)
                            }
                            .padding(.leading, 10)
                            .offset(y: 28)
                        }
                    }
                }
                .offset(y: -220)
            }
                    Text("History")
                    Text("Messages")
                    Text("Your Addresses")
                    .padding()
                    Text("Log out")
                    Text("Need Help?")
                    .padding()
                    .background(Color.gray.opacity(0.1))
                }
                .padding()
            }
        }
#Preview {
    settings()
}


