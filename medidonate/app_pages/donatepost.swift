//
//  home.swift
//  medidonate
//
//  Created by fares kassis on 21/3/2024.
//

import SwiftUI
struct donatepost: View {
    @State var text: String = ""
    @State var category: String = ""
    @State private var fab_date = Date()
    @State private var exp_date = Date()
    @State private var quantity: Int = 0
    @State var choicemade = "Tap to select medicine's type"
    @State var medicinee = "tap to select medicine's name"
    @State var donate: Bool = false
    var body: some View {
        NavigationView{
            ScrollView{
                VStack(alignment: .leading){
                    HStack{
                        Group{
                            NavigationLink (destination: home().navigationBarBackButtonHidden(), label: {
                                Image(systemName: "plus")
                                    .padding(.leading, 20)
                                    .font(.title)
                                    .rotationEffect(.degrees(45))
                                    .offset(x: 5, y: -6)
                                    .foregroundColor(.black)
                            })
                            Text("Create post")
                                .fontWeight(.semibold)
                                .font(.title2)
                                .foregroundColor(.black)
                                .offset(x: -5)
                            ZStack{
                                Rectangle()
                                    .cornerRadius(12)
                                    .foregroundStyle(Color.primarycolor)
                                    .frame(width: 65, height: 40, alignment: .center)
                                Text("Post")
                                    .font(.title2)
                                    .fontWeight(.semibold)
                                    .multilineTextAlignment(.center)
                                    .foregroundStyle(.white)
                            }
                            .padding(.trailing, 50)
                        }
                        .frame(width: 170, height: 50)
                    }
                    HStack(spacing: -8){
                        Image(systemName: "person.circle.fill")
                            .resizable(resizingMode: .tile)
                            .frame(width: 50, height: 50)
                            .padding(.leading, 80)
                            .foregroundColor(.green)
                        VStack(alignment: .leading){
                            Text("Freas Kassis")
                                .font(.title3)
                                .fontWeight(.semibold)
                            HStack{
                                NavigationLink (destination: requestpost().navigationBarBackButtonHidden(), label:{
                                    ZStack{
                                        RoundedRectangle(cornerRadius: 30)
                                            .stroke(Color.primarycolor, lineWidth: 1)
                                            .foregroundStyle(Color.white)
                                            .frame(width: 75, height: 40, alignment: .center)
                                        Text("Request")
                                            .multilineTextAlignment(.center)
                                            .foregroundStyle(.primarycolor)
                                    }
                                })
                                NavigationLink (destination: donatepost().navigationBarBackButtonHidden(), label:{
                                    ZStack{
                                        RoundedRectangle(cornerRadius: 30)
                                            .foregroundStyle(Color.primarycolor)
                                            .frame(width: 75, height: 40, alignment: .center)
                                        Text("Donate")
                                            .multilineTextAlignment(.center)
                                            .foregroundStyle(.white)
                                    }
                                })
                            }
                        }
                        .frame(width: 200, height: 60)
                        .padding(.leading, 8)
                    }
                    .padding(.top)
                    TextField("What's on your mind ?", text: $text)
                        .font(.title2)
                        .frame(width: 300, height: 50)
                        .background(Color.white)
                        .padding(.leading, 85)
                        .padding(.top)
                }
                Group{
                    Button(action: {
                        donate.toggle()
                    }, label: {
                        ZStack{
                            RoundedRectangle(cornerRadius: 30)
                                .stroke(Color.primarycolor, lineWidth: 1)
                                .foregroundStyle(Color.white)
                                .frame(width: 200, height: 40, alignment: .center)
                            HStack{
                                Image(systemName: "pills")
                                    .foregroundColor(.primarycolor)
                                Text("Add medicines")
                                    .foregroundColor(.primarycolor)
                                Image(systemName: "plus.circle")
                                    .foregroundColor(.primarycolor)
                            }
                        }
                    })
                    if donate{
                        Group{
                            ZStack{
                                VStack{
                                    Text("Medicine Name")
                                        .offset(x: -120)
                                        .frame(height: 25)
                                    ZStack(alignment: .leading){
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(Color.black, lineWidth: 2)
                                            .foregroundColor(.white)
                                            .frame(width: 365, height: 50)
                                            .cornerRadius(10)
                                        Menu("\(medicinee)"){
                                            Button("panadole"){
                                                medicinee = "panadole"
                                            }
                                            Button("maxilase"){
                                                medicinee = "maxilase"
                                            }
                                            Button("vaccines"){
                                                medicinee = "vaccines"
                                            }
                                            Button("moov"){
                                                medicinee = "moov"
                                            }
                                        }
                                        .foregroundColor(.gray)
                                        .padding(.leading)
                                        .frame(width: 250, alignment: .leading)
                                    }
                                    Text("Medicine Category")
                                        .offset(x: -105)
                                        .frame(height: 25)
                                    ZStack(alignment: .leading){
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(Color.black, lineWidth: 2)
                                            .foregroundColor(.white)
                                            .frame(width: 365, height: 50)
                                            .cornerRadius(10)
                                        TextField("Medicine category(it will be auto fill)", text: $category)
                                            .font(.headline)
                                            .frame(width: 300, height: 50)
                                            .padding(.leading)
                                            .fontWeight(.regular)
                                    }
                                    Text("Medicine Type")
                                        .offset(x: -120)
                                        .frame(height: 25)
                                    ZStack(alignment: .leading){
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(Color.black, lineWidth: 2)
                                            .foregroundColor(.white)
                                            .frame(width: 365, height: 50)
                                            .cornerRadius(10)
                                        Menu("\(choicemade)"){
                                            Button("pills"){
                                                choicemade = "pills"
                                            }
                                            Button("sirop"){
                                                choicemade = "sirop"
                                            }
                                            Button("injections"){
                                                choicemade = "injections"
                                            }
                                            Button("spray"){
                                                choicemade = "spray"
                                            }
                                        }
                                        .foregroundColor(.gray)
                                        .padding(.leading)
                                        .frame(width: 250, alignment: .leading)
                                    }
                                    ZStack{
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(Color.black, lineWidth: 2)
                                            .foregroundColor(.white)
                                            .frame(width: 300, height: 50)
                                            .cornerRadius(10)
                                            .padding(.top, 3)
                                        Stepper(value: $quantity, in: 0...100,step: 1){
                                            Text("Quantity: \(quantity)")
                                        }
                                        .frame(width: 220)
                                    }
                                    ZStack{
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(Color.black, lineWidth: 2)
                                            .foregroundColor(.white)
                                            .frame(width: 300, height: 50)
                                            .cornerRadius(10)
                                            .padding(.top, 3)
                                            .padding(.bottom, 3)
                                        DatePicker("Fab_Date", selection: $fab_date, in: ...Date(), displayedComponents:.date)
                                            .frame(width: 220)
                                    }
                                    ZStack{
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(Color.black, lineWidth: 2)
                                            .foregroundColor(.white)
                                            .frame(width: 300, height: 50)
                                            .cornerRadius(10)
                                        DatePicker("Exp_Date", selection: $exp_date, in: Date()..., displayedComponents:.date)
                                            .frame(width: 220)
                                    }
                                    HStack(spacing: 30){
                                        Group{
                                            Button {
                                                donate.toggle()
                                            } label: {
                                                ZStack{
                                                    RoundedRectangle(cornerRadius: 15)
                                                        .stroke(Color.primarycolor, lineWidth: 1)
                                                        .foregroundStyle(Color.white)
                                                        .frame(width: 100, height: 40, alignment: .center)
                                                    HStack{
                                                        Text("Cancel")
                                                            .fontWeight(.medium)
                                                            .foregroundColor(.primarycolor)
                                                    }
                                                }
                                            }
                                            
                                            NavigationLink (destination: addmedicine().navigationBarBackButtonHidden(), label:{
                                                ZStack{
                                                    RoundedRectangle(cornerRadius: 15)
                                                        .foregroundStyle(Color.primarycolor)
                                                        .frame(width: 100, height: 40, alignment: .center)
                                                    HStack{
                                                        Text("Add")
                                                            .fontWeight(.medium)
                                                            .foregroundColor(.white)
                                                    }
                                                }
                                            })
                                        }
                                        .offset(y: 20)
                                    }
                                }
                            }
                        }
                        .background()
                        .offset(y: -450)
                        .transition(.move(edge: .bottom))
                        .animation(.easeInOut)
                        .edgesIgnoringSafeArea(.bottom)
                    }
                }
                .offset(y: 400)
            }
        }
    }
}
#Preview {
    donatepost()
}
