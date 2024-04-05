//
//  settings.swift
//  medidonate
//
//  Created by fares kassis on 11/3/2024.
//

import SwiftUI

struct conversation: View {
    @State var message: String = ""
    var body: some View {
        NavigationView{
            VStack {
                ScrollView{
                    ZStack{
                        Group{
                            Rectangle()
                                .fill(Color.primarycolor)
                                .frame(width: 400, height: 180)
                            Text("Messages")
                                .font(.title2)
                                .foregroundColor(Color.white)
                                .offset(x: -100, y:-12)
                            VStack{
                                Image(systemName: "person.circle.fill")
                                    .resizable(resizingMode: .tile)
                                    .frame(width: 50, height: 50)
                                    .padding(.leading, 5)
                                HStack{
                                    Text("Stephen Yustiono")
                                        .font(.footnote)
                                        .foregroundColor(.white)
                                    Image(systemName: "chevron.forward")
                                        .foregroundColor(.white)
                                        .font(.footnote)
                                }
                            }
                            .offset(y: 35)
                        }
                        .offset(y: -100)
                    }
                    ZStack{
                        RoundedRectangle(cornerRadius: 15)
                            .foregroundStyle(Color.primarycolor)
                            .frame(width: 250, height: 80, alignment: .center)
                        Text("Lorem ipsum dolor sit")
                            .padding(.bottom, 50)
                        Text("amet, consectetur.")
                            .fontWeight(.medium)
                            .foregroundColor(.white)
                    }
                    .offset(x: 60, y: -90)
                    ZStack{
                        RoundedRectangle(cornerRadius: 15)
                            .foregroundStyle(Color.primarycolor)
                            .frame(width: 250, height: 80, alignment: .center)
                        Text("Lorem ipsum dolor sit")
                            .padding(.bottom, 50)
                        Text("amet, consectetur.")
                            .fontWeight(.medium)
                            .foregroundColor(.white)
                    }
                    .offset(x: 60, y: -90)
                    ZStack{
                        RoundedRectangle(cornerRadius: 15)
                            .foregroundStyle(Color.primarycolor)
                            .frame(width: 250, height: 80, alignment: .center)
                        Text("Lorem ipsum dolor sit")
                            .padding(.bottom, 50)
                        Text("amet, consectetur.")
                            .fontWeight(.medium)
                            .foregroundColor(.white)
                    }
                    .offset(x: 60, y: -90)
                    ZStack{
                        RoundedRectangle(cornerRadius: 15)
                            .foregroundStyle(Color.primarycolor)
                            .frame(width: 250, height: 80, alignment: .center)
                        Text("Lorem ipsum dolor sit")
                            .padding(.bottom, 50)
                        Text("amet, consectetur.")
                            .fontWeight(.medium)
                            .foregroundColor(.white)
                    }
                    .offset(x: 60, y: -90)
                    ZStack{
                        RoundedRectangle(cornerRadius: 15)
                            .foregroundStyle(Color.primarycolor)
                            .frame(width: 250, height: 80, alignment: .center)
                        Text("Lorem ipsum dolor sit")
                            .padding(.bottom, 50)
                        Text("amet, consectetur.")
                            .fontWeight(.medium)
                            .foregroundColor(.white)
                    }
                    .offset(x: 60, y: -90)
                    ZStack{
                        RoundedRectangle(cornerRadius: 15)
                            .foregroundStyle(Color.primarycolor)
                            .frame(width: 250, height: 80, alignment: .center)
                        Text("Lorem ipsum dolor sit")
                            .padding(.bottom, 50)
                        Text("amet, consectetur.")
                            .fontWeight(.medium)
                            .foregroundColor(.white)
                    }
                    .offset(x: 60, y: -90)
                    ZStack{
                        RoundedRectangle(cornerRadius: 15)
                            .foregroundStyle(Color.primarycolor)
                            .frame(width: 250, height: 80, alignment: .center)
                        Text("Lorem ipsum dolor sit")
                            .padding(.bottom, 50)
                        Text("amet, consectetur.")
                            .fontWeight(.medium)
                            .foregroundColor(.white)
                    }
                    .offset(x: 60, y: -90)
                    ZStack{
                        RoundedRectangle(cornerRadius: 15)
                            .foregroundStyle(Color.primarycolor)
                            .frame(width: 250, height: 80, alignment: .center)
                        Text("Lorem ipsum dolor sit")
                            .padding(.bottom, 50)
                        Text("amet, consectetur.")
                            .fontWeight(.medium)
                            .foregroundColor(.white)
                    }
                    .offset(x: 60, y: -90)
                    TextField("hello", text: $message, axis: .vertical)
                        .background(.red)
                        .lineLimit(/*@START_MENU_TOKEN@*/2/*@END_MENU_TOKEN@*/)
                }
                .navigationBarItems(leading:NavigationLink(destination: home().navigationBarBackButtonHidden(), label: {Image(systemName: "chevron.backward")
                        .font(.title2)
                .foregroundColor(.white)}))
            }
        }
    }
}
#Preview {
    conversation()
}
struct messagebar: View {
    @State var message: String = ""
    var body: some View {
        VStack {
            ScrollView{
                TextField("hello", text: $message, axis: .vertical)
                    .background(.red)
            }
        }
    }
}
#Preview {
    messagebar()
}

