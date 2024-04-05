//
//  ContentView.swift
//  medidonate
//
//  Created by fares kassis on 7/3/2024.
//

import SwiftUI

struct historydonate: View {
    @State var email: String = ""
    @State var password: String = ""
    var body: some View {
        NavigationView(){
            ScrollView{
                ZStack{
                    Circle()
                        .fill(Color.primarycolor)
                        .frame(width: 1000, height: 575)
                        .offset(x: -180, y: -530)
                        .rotationEffect(.degrees(10))
                    Text("History")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(Color.white)
                        .offset(x: -110, y: -390)
                    NavigationLink(destination: historyrequest().navigationBarBackButtonHidden(), label: {ZStack{
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(Color.white, lineWidth: 1)
                            .foregroundStyle(Color.white)
                            .frame(width: 80, height: 40, alignment: .center)
                        HStack{
                            Text("Request")
                                .fontWeight(.medium)
                                .foregroundColor(.white)
                        }
                    }})
                    .offset(x: -130, y: -320)
                    ZStack{
                        RoundedRectangle(cornerRadius: 15)
                            .foregroundStyle(Color.secondarycolor)
                            .frame(width: 80, height: 40, alignment: .center)
                        Text("Donation")
                            .fontWeight(.medium)
                            .foregroundColor(.white)
                    }
                    .offset(x: -35, y: -320)
                }
                .offset(y: 80)
                VStack {
                    ZStack{
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color.gray4)
                            .cornerRadius(20)
                            .foregroundColor(.white)
                            .frame(width: 365, height: 150)
                        HStack(spacing: 10){
                            Image(systemName: "basket")
                                .font(.system(size: 100))
                                .foregroundColor(.primarycolor)
                            VStack(alignment: .leading){
                                Text("Donation Number #2001")
                                    .font(.headline)
                                    .fontWeight(.regular)
                                Text("Date: 20/02/2024")
                                    .font(.callout)
                                    .fontWeight(.light)
                                    .foregroundColor(.gray)
                            }
                            .frame(width: 200, height: 100, alignment: .topLeading)
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
                            Image(systemName: "basket")
                                .font(.system(size: 100))
                                .foregroundColor(.primarycolor)
                            VStack(alignment: .leading){
                                Text("Donation Number #2001")
                                    .font(.headline)
                                    .fontWeight(.regular)
                                Text("Date: 20/02/2024")
                                    .font(.callout)
                                    .fontWeight(.light)
                                    .foregroundColor(.gray)
                            }
                            .frame(width: 200, height: 100, alignment: .topLeading)
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
                            Image(systemName: "basket")
                                .font(.system(size: 100))
                                .foregroundColor(.primarycolor)
                            VStack(alignment: .leading){
                                Text("Donation Number #2001")
                                    .font(.headline)
                                    .fontWeight(.regular)
                                Text("Date: 20/02/2024")
                                    .font(.callout)
                                    .fontWeight(.light)
                                    .foregroundColor(.gray)
                            }
                            .frame(width: 200, height: 100, alignment: .topLeading)
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
                            Image(systemName: "basket")
                                .font(.system(size: 100))
                                .foregroundColor(.primarycolor)
                            VStack(alignment: .leading){
                                Text("Donation Number #2001")
                                    .font(.headline)
                                    .fontWeight(.regular)
                                Text("Date: 20/02/2024")
                                    .font(.callout)
                                    .fontWeight(.light)
                                    .foregroundColor(.gray)
                            }
                            .frame(width: 200, height: 100, alignment: .topLeading)
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
                            Image(systemName: "basket")
                                .font(.system(size: 100))
                                .foregroundColor(.primarycolor)
                            VStack(alignment: .leading){
                                Text("Donation Number #2001")
                                    .font(.headline)
                                    .fontWeight(.regular)
                                Text("Date: 20/02/2024")
                                    .font(.callout)
                                    .fontWeight(.light)
                                    .foregroundColor(.gray)
                            }
                            .frame(width: 200, height: 100, alignment: .topLeading)
                        }
                    }
                    .offset(y:-480)
                }
            }
            .navigationBarItems(leading:NavigationLink(destination: settings().navigationBarBackButtonHidden(), label: {Image(systemName: "chevron.backward")
                    .font(.title2)
            .foregroundColor(.white)}))
        }
    }
}
#Preview {
    historydonate()
}