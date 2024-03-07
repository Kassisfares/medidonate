//
//  signup.swift
//  medidonate
//
//  Created by fares kassis on 7/3/2024.
//

import SwiftUI

struct signup: View {
    var body: some View {
        ZStack{
            Circle()
                .fill(Color.primarycolor)
                .frame(width: 1000, height: 575)
                .offset(x: -140, y: -480)
                .rotationEffect(.degrees(10))
            Text("Create An")
                .font(.system(size: 50))
                .fontWeight(.bold)
                .foregroundColor(Color.white)
                .offset(x: -44, y: -310)
            Text("Account")
                .font(.system(size: 50))
                .fontWeight(.bold)
                .foregroundColor(Color.white)
                .offset(x: -60, y: -260)
            Image(systemName: "arrowshape.left.circle")
                .font(.system(size: 30))
                .foregroundColor(Color.white)
                .frame(width: 200, height: 200)
                .offset(x: -160, y: -360)
        }
    }
}

#Preview {
    signup()
}
