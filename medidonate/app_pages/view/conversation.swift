//
//  settings.swift
//  medidonate
//
//  Created by fares kassis on 11/3/2024.
//

import SwiftUI

struct conversation: View {
    @State var messages: String = ""
    var body: some View {
        NavigationView{
            VStack {
                ZStack{
                        VStack{
                            Image(systemName: "person.circle")
                                .resizable(resizingMode: .tile)
                                .frame(width: 50, height: 50)
                                .foregroundColor(.primarycolor)
                            HStack{
                                Text("Mohamed")
                                    .font(.headline)
                                    .foregroundColor(.black)
                            }
                        }
                        .offset(y: -20)
                }
                ScrollView{
                    ForEach(0..<2){ index in
                        let condition = index%2 == 0
                        let condition1 = index%1 == 1
                        ZStack{
                            RoundedRectangle(cornerRadius: 15)
                                .foregroundStyle(condition ? Color(.primarycolor) : Color(.gray4))
                                .frame(width: 250, height: 80, alignment: .leading)
                                .padding(condition ? .trailing : .leading, -100)
                            VStack(alignment: .leading){
                                Text(condition ? "Salut, ce médicament est disponible maintenant ??" : "Salut, Oui bien sur il est disponible .")
                                    .frame(width: 225)
                                    .fontWeight(.medium)
                                    .foregroundColor(.white)
                                    .padding(condition1 ? .trailing : .leading, -10)
                                    .padding(condition ? .trailing : .leading, -90)
                            }
                        }
                    }
                    .frame(width: 390.0)
                }
                VStack {
                    ZStack{
                        Group{
                            RoundedRectangle(cornerRadius: 30)
                                .frame(width: 350, height: 50)
                                .padding(.all, 8)
                                .foregroundColor(Color.white)
                                .cornerRadius(30)
                                .shadow(color: .black, radius: 2)
                            TextField("Aa", text: $messages, axis: .vertical)
                                .frame(width: 280, height: 50)
                                .offset(x: -20)
                            NavigationLink(destination: conversation().navigationBarBackButtonHidden(), label: {Image(systemName: "arrow.up.circle.fill")
                                    .foregroundColor(Color("primarycolor"))
                                .font(.system(size: 35))})
                            .offset(x: 150)
                        }
                    }
                }
            }
            .navigationBarItems(leading:NavigationLink(destination: message().navigationBarBackButtonHidden(), label: {Image(systemName: "chevron.backward")
                    .font(.title2)
                .foregroundColor(.black)}))
        }
    }
}
#Preview {
    conversation()
}

