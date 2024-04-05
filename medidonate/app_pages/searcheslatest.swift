//
//  signup.swift
//  medidonate
//
//  Created by fares kassis on 7/3/2024.
//

import SwiftUI

struct searcheslatest: View {
    @State var search: String = ""
    var body: some View {
        NavigationView{
            ScrollView{
                ZStack{
                    Circle()
                        .fill(Color.primarycolor)
                        .frame(width: 5500, height: 575)
                        .offset( y: -440)
                    ZStack{
                        TextField("search", text: $search)
                            .frame(width: 300, height: 10)
                            .padding()
                            .background(Color.gray5)
                            .cornerRadius(20)
                            .foregroundColor(.gray)
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                            .offset(x: 140)
                    }
                    .offset(y: -260)
                    NavigationLink(destination: searchesall().navigationBarBackButtonHidden(), label: {ZStack{
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(Color.white, lineWidth: 1)
                            .foregroundStyle(Color.primarycolor)
                            .frame(width: 50, height: 40, alignment: .center)
                        Text("ALL")
                            .fontWeight(.medium)
                            .foregroundColor(.white)
                    }})
                    .offset(x: -40, y: -200)
                    ZStack{
                        RoundedRectangle(cornerRadius: 15)
                            .foregroundStyle(Color.secondarycolor)
                            .frame(width: 80, height: 40, alignment: .center)
                        HStack{
                            Text("Latest")
                                .fontWeight(.medium)
                                .foregroundColor(.white)
                        }
                    }
                    .offset(x: 40, y: -200)
                }
                VStack {
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
                        }
                    }
                    .offset(y:-480)
                }
                .offset(y: 50)
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(leading:NavigationLink(destination: home().navigationBarBackButtonHidden(), label: {Image(systemName: "chevron.backward")
                    .font(.title2)
                    .foregroundColor(.white)}))
        }
    }
}
#Preview {
    searcheslatest()
}
