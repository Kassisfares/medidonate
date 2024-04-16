//
//  signup.swift
//  medidonate
//
//  Created by fares kassis on 7/3/2024.
//

import SwiftUI

struct requestmedicine: View {
    @State var showview: Bool = false
    var body: some View {
        NavigationView{
            VStack{
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
                    HStack(spacing: 20){
                        Group{
                            NavigationLink (destination: editrequestmedicine().navigationBarBackButtonHidden(), label:{
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
                            })
                            Button {
                                showview.toggle()
                            } label: {
                                ZStack{
                                    RoundedRectangle(cornerRadius: 15)
                                        .foregroundStyle(Color.primarycolor)
                                        .frame(width: 150, height: 40, alignment: .center)
                                    HStack{
                                        Text("Choose location")
                                            .fontWeight(.medium)
                                            .foregroundColor(.white)
                                    }
                                }
                            }
                            if showview {
                                ZStack(alignment: .bottom){
                                    Rectangle()
                                        .frame(width: 400, height: 430)
                                        .foregroundColor(.primarycolor)
                                        .cornerRadius(50)
                                    VStack{
                                        HStack{
                                            Button(action: {
                                                showview.toggle()
                                            }, label: {
                                                Image(systemName: "plus")
                                                    .padding(.leading, 20)
                                                    .font(.title)
                                                    .rotationEffect(.degrees(45))
                                                    .foregroundColor(.white)
                                            })
                                            .offset(x: -70, y: -7)
                                            Text("Choose location")
                                                .font(.title)
                                                .foregroundColor(.white)
                                                .offset(x: -25)
                                        }
                                        Text("Set location on map")
                                            .font(.title3)
                                            .foregroundColor(.white)
                                            .offset(x: -90)
                                            .padding(.bottom, 10)
                                        NavigationLink (destination: chooserequestlocation2().navigationBarBackButtonHidden(), label:{
                                            Image("map")
                                                .resizable(resizingMode: .stretch)
                                                .frame(width: 300, height: 200)
                                        })
                                        HStack{
                                            Rectangle()
                                                .fill(Color.gray3)
                                                .frame(width:100, height: 2)
                                                .offset(y: -2)
                                            Text("Or")
                                                .foregroundColor(.white)
                                                .padding(.leading)
                                                .padding(.trailing)
                                            Rectangle()
                                                .fill(Color.gray3)
                                                .frame(width:100, height: 2)
                                                .offset(y: -2)
                                        }
                                        .padding(.top, 10)
                                        .padding(.bottom, 10)
                                        NavigationLink (destination: chooserequestlocation2().navigationBarBackButtonHidden(), label:{
                                            ZStack{
                                                Rectangle()
                                                    .cornerRadius(12)
                                                    .foregroundStyle(Color.white)
                                                    .frame(width: 250, height: 40, alignment: .center)
                                                HStack{
                                                    Image(systemName: "plus")
                                                        .foregroundColor(.primarycolor)
                                                        .fontWeight(.medium)
                                                    Text("Add new location")
                                                        .font(.title2)
                                                        .fontWeight(.medium)
                                                        .multilineTextAlignment(.center)
                                                        .foregroundStyle(.primarycolor)
                                                }
                                            }
                                        })
                                    }
                                    .offset(y: -20)
                                }
                                .offset(x: -142, y: -340)
                                .transition(.move(edge: .bottom))
                                .animation(.easeInOut)
                                .edgesIgnoringSafeArea(.bottom)
                            }
                        }
                    }
                    .offset(y: -230)
                }
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarItems(leading:NavigationLink(destination: home().navigationBarBackButtonHidden(), label: {Image(systemName: "chevron.backward")
                        .font(.title2)
                    .foregroundColor(.white)}))
            }
        }
    }
}
#Preview {
    requestmedicine()
}
