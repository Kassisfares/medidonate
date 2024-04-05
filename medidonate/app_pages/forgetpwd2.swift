//
//  forgetpwd2.swift
//  medidonate
//
//  Created by fares kassis on 13/3/2024.
//

import SwiftUI

struct forgetpwd2: View {
    var body: some View {
        VStack(){
            VStack(alignment: .leading){
                Text("Reset email sent")
                    .font(.title)
                    .fontWeight(.regular)
                    .padding(.leading, 5)
                    .padding(.top)
                    .padding(.bottom, 8)
                Text("We have sent an instructions email to fareskas123@gmail.com")
                    .font(.title3)
                    .foregroundColor(Color("gray2"))
                    .padding(.leading, 5)
            }
            NavigationLink(destination: login().navigationBarBackButtonHidden()){
                ZStack(){
                    Group{
                        Rectangle()
                            .cornerRadius(12)
                            .padding(.all)
                            .foregroundStyle(Color.secondarycolor)
                            .frame(width: 300, height: 100, alignment: .center)
                        Text("Done")
                            .font(.title)
                            .fontWeight(.semibold)
                            .multilineTextAlignment(.center)
                            .foregroundStyle(.white)
                    }
                }
            }
        }
        Spacer()
    }
}
    
#Preview {
    forgetpwd2()
}
