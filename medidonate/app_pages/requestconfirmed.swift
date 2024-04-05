//
//  signup.swift
//  medidonate
//
//  Created by fares kassis on 7/3/2024.
//

import SwiftUI

struct requestconfirmed: View {
    var body: some View {
        NavigationView{
            ScrollView{
                ZStack{
                        Circle()
                            .fill(Color.primarycolor)
                            .frame(width: 1500, height: 575)
                            .offset( y: -490)
                        Text("Request medicines")
                            .font(.title2)
                            .foregroundColor(.white)
                            .frame(width: 200, height: 50)
                            .offset(x:-60, y:-310)
                }
                ZStack{
                    Rectangle()
                        .frame(width: 400, height: 650)
                        .foregroundColor(.primarycolor)
                        .cornerRadius(50)
                    VStack(alignment: .leading){
                        Text("Request Confirmed #2001")
                            .font(.title)
                            .foregroundColor(.white)
                            .padding(.leading)
                        Rectangle()
                            .fill(Color.gray3)
                            .frame(width:400, height: 2)
                        Text("+ Panadol")
                            .foregroundColor(.white)
                            .padding(.leading)
                        Text("+ Vaccin")
                            .foregroundColor(.white)
                            .padding(.leading)
                        Rectangle()
                            .fill(Color.gray3)
                            .frame(width:400, height: 2)
                        Text("Address")
                            .font(.title2)
                            .foregroundColor(.white)
                            .padding(.leading)
                        Image("map")
                            .resizable(resizingMode: .stretch)
                            .frame(width: 250, height: 150)
                            .padding(.leading)
                            .offset(x: 60)
                        Text("Description")
                            .foregroundColor(.white)
                            .padding(.leading)
                            .font(.title2)
                        ZStack(alignment: Alignment(horizontal: .center, vertical: .center)){
                            Rectangle()
                                .frame(width: 350, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
                                .padding(.leading, 25)
                                .foregroundColor(.gray3)
                            VStack{
                                Text("Rue El Ain Km 4.5")
                                Text("apres salon de thé troquette a gauche")
                            }
                        }
                    }
                    .offset(y: -50)
                }
                .offset(y: -465)
                NavigationLink (destination: home().navigationBarBackButtonHidden(), label:{
                    ZStack{
                        Rectangle()
                            .cornerRadius(12)
                            .foregroundStyle(Color.white)
                            .frame(width: 250, height: 40, alignment: .center)
                            .padding()
                        Text("Done")
                            .font(.title2)
                            .fontWeight(.medium)
                            .multilineTextAlignment(.center)
                            .foregroundStyle(.primarycolor)
                    }
                })
                .offset(y: -590)
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(leading:NavigationLink(destination: home().navigationBarBackButtonHidden(), label: {Image(systemName: "chevron.backward")
                    .font(.title2)
                    .foregroundColor(.white)}))
        }
    }
}
#Preview {
    requestconfirmed()
}
