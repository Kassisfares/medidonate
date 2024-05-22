//
//  signup.swift
//  medidonate
//
//  Created by fares kassis on 7/3/2024.
//

import SwiftUI

struct editrequestmedicine3: View {
    @State var showview9: Bool = false
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
                            showview9.toggle()
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
                        if showview9 {
                            ZStack(alignment: .bottom){
                                Rectangle()
                                    .frame(width: 400, height: 430)
                                    .foregroundColor(.primarycolor)
                                    .cornerRadius(50)
                                VStack{
                                    HStack{
                                        Button(action: {
                                            showview9.toggle()
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
                                    NavigationLink (destination: chooserequestlocation2_after_edit().navigationBarBackButtonHidden(), label:{
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
                                    NavigationLink (destination: chooserequestlocation2_after_edit().navigationBarBackButtonHidden(), label:{
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
                            .offset(x: -142, y: -180)
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
#Preview {
    editrequestmedicine3()
}


//
//  signup.swift
//  medidonate
//
//  Created by fares kassis on 7/3/2024.
//

import SwiftUI

struct chooserequestlocation2_after_edit: View {
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
                    Rectangle()
                        .frame(width: 400, height: 430)
                        .foregroundColor(.primarycolor)
                        .cornerRadius(50)
                    VStack{
                        Text("Location confirmed")
                            .font(.title)
                            .foregroundColor(.white)
                        Image("map")
                            .resizable(resizingMode: .stretch)
                            .frame(width: 300, height: 230)
                        NavigationLink (destination: chooserequestlocation3_after_edit().navigationBarBackButtonHidden(), label:{
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
                    }
                }
                .offset(y: -410)
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(leading:NavigationLink(destination: home().navigationBarBackButtonHidden(), label: {Image(systemName: "chevron.backward")
                    .font(.title2)
                    .foregroundColor(.white)}))
        }
    }
}
#Preview {
    chooserequestlocation2_after_edit()
}

//
//  signup.swift
//  medidonate
//
//  Created by fares kassis on 7/3/2024.
//

import SwiftUI

struct chooserequestlocation3_after_edit: View {
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
                        NavigationLink (destination: confirmerequest_after_edit().navigationBarBackButtonHidden(), label:{
                            ZStack{
                                RoundedRectangle(cornerRadius: 15)
                                    .foregroundStyle(Color.primarycolor)
                                    .frame(width: 150, height: 40, alignment: .center)
                                HStack{
                                    Text("Request")
                                        .fontWeight(.medium)
                                        .foregroundColor(.white)
                                }
                            }
                        })
                    }
                }
                .offset(y: -150)
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(leading:NavigationLink(destination: home().navigationBarBackButtonHidden(), label: {Image(systemName: "chevron.backward")
                    .font(.title2)
                    .foregroundColor(.white)}))
        }
    }
}
#Preview {
    chooserequestlocation3_after_edit()
}

//
//  signup.swift
//  medidonate
//
//  Created by fares kassis on 7/3/2024.
//

import SwiftUI

struct confirmerequest_after_edit: View {
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
                .offset(y: -150)
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
                        NavigationLink (destination: chooserequestlocation3_after_edit().navigationBarBackButtonHidden(), label:{
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
                .offset(y: -550)
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(leading:NavigationLink(destination: home().navigationBarBackButtonHidden(), label: {Image(systemName: "chevron.backward")
                    .font(.title2)
                    .foregroundColor(.white)}))
        }
    }
}
#Preview {
    confirmerequest_after_edit()
}



