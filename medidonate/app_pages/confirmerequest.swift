//
//  signup.swift
//  medidonate
//
//  Created by fares kassis on 7/3/2024.
//

import SwiftUI

struct confirmerequest: View {
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
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.gray4)
                        .cornerRadius(20)
                        .foregroundColor(.white)
                        .frame(width: 365, height: 150)
                    HStack(spacing: 10){
                        Image("panadol")
                            .resizable(resizingMode: .stretch)
                            .frame(width: 90, height: 120)
                        VStack(alignment: .leading){
                            Text("Panadol 500mg")
                                .font(.headline)
                                .fontWeight(.regular)
                            Text("Category : Paracetamol")
                                .font(.callout)
                                .fontWeight(.light)
                                .foregroundColor(.gray)
                        }
                        .frame(width: 200, height: 100, alignment: .topLeading)
                        NavigationLink(destination: requestmedicineinfo().navigationBarBackButtonHidden(), label: {Image(systemName: "arrow.forward.circle")
                                .font(.title2)
                                .foregroundColor(.primarycolor)})
                        .offset(y: -40)
                    }
                }
                .offset(y:-480)
                ZStack{
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.gray4)
                        .cornerRadius(20)
                        .foregroundColor(.white)
                        .frame(width: 365, height: 150)
                    HStack(spacing: 10){
                        Image("vaccin")
                            .resizable(resizingMode: .stretch)
                            .frame(width: 90, height: 120)
                        VStack(alignment: .leading){
                            Text("Corona vaccin")
                                .font(.headline)
                                .fontWeight(.regular)
                            Text("Category : vaccin")
                                .font(.callout)
                                .fontWeight(.light)
                                .foregroundColor(.gray)
                        }
                        .frame(width: 200, height: 100, alignment: .topLeading)
                        NavigationLink(destination: requestmedicineinfo().navigationBarBackButtonHidden(), label: {Image(systemName: "arrow.forward.circle")
                                .font(.title2)
                                .foregroundColor(.primarycolor)})
                        .offset(y: -40)
                    }
                }
                .offset(y:-480)
                VStack{
                    ZStack{
                        RoundedRectangle(cornerRadius: 30)
                            .stroke(Color.secondarycolor, lineWidth: 1)
                            .foregroundStyle(Color.white)
                            .frame(width: 180, height: 40, alignment: .center)
                        HStack{
                            Image(systemName: "map.circle")
                                .foregroundColor(.secondarycolor)
                            Text("Address added")
                                .foregroundColor(.secondarycolor)
                            Image(systemName: "checkmark.circle")
                                .foregroundColor(.secondarycolor)
                        }
                    }
                    HStack{
                        ZStack{
                            RoundedRectangle(cornerRadius: 15)
                                .stroke(Color.primarycolor, lineWidth: 1)
                                .foregroundStyle(Color.white)
                                .frame(width: 100, height: 40, alignment: .center)
                            HStack{
                                Text("Edit")
                                    .fontWeight(.medium)
                                    .foregroundColor(.primarycolor)
                            }
                        }
                        ZStack{
                            RoundedRectangle(cornerRadius: 15)
                                .foregroundStyle(Color.primarycolor)
                                .frame(width: 150, height: 40, alignment: .center)
                            Text("Request")
                                .fontWeight(.medium)
                                .foregroundColor(.white)
                        }
                    }
                }
                .offset(y: -300)
                ZStack{
                    RoundedRectangle(cornerRadius: 15)
                        .foregroundStyle(Color.primarycolor)
                        .frame(width: 350, height: 220, alignment: .center)
                    VStack{
                        Text("Confirm request ?")
                            .font(.title2)
                            .fontWeight(.medium)
                            .foregroundColor(.white)
                        NavigationLink (destination: home().navigationBarBackButtonHidden(), label:{
                            ZStack{
                                RoundedRectangle(cornerRadius: 15)
                                    .foregroundStyle(Color.white)
                                    .frame(width: 80, height: 40, alignment: .center)
                                Text("Yes")
                                    .font(.headline)
                                    .fontWeight(.medium)
                                    .foregroundColor(.green)
                            }
                        })
                        NavigationLink (destination: chooserequestlocation3().navigationBarBackButtonHidden(), label:{
                            ZStack{
                                RoundedRectangle(cornerRadius: 15)
                                    .foregroundStyle(Color.white)
                                    .frame(width: 80, height: 40, alignment: .center)
                                Text("No")
                                    .font(.headline)
                                    .fontWeight(.medium)
                                    .foregroundColor(.red)
                            }
                        })
                    }
                }
                .offset(y: -750)
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(leading:NavigationLink(destination: home().navigationBarBackButtonHidden(), label: {Image(systemName: "chevron.backward")
                    .font(.title2)
                    .foregroundColor(.white)}))
        }
    }
}
#Preview {
    confirmerequest()
}
