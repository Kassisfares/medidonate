//
//  signup.swift
//  medidonate
//
//  Created by fares kassis on 7/3/2024.
//

import SwiftUI

struct requestmedicineinfo: View {
    @State private var quantity: Int = 0
    @Environment(\.dismiss) private var dismiss
    var body: some View {
        NavigationView{
            ScrollView{
                Image("panadol")
                    .resizable(resizingMode: .stretch)
                    .frame(width: 150, height:
                            180)
                    .padding()
                VStack(alignment: .leading){
                    Group{
                        Text("Panadol")
                            .font(.title3)
                        Text("Panadol 500mg Film-coated tablets")
                            .font(.subheadline)
                            .fontWeight(.light)
                        Text("24 Tablets")
                            .font(.footnote)
                            .fontWeight(.light)
                            .foregroundColor(.gray)
                    }
                    .padding(.leading, 40)
                    Rectangle()
                        .fill(Color.gray3)
                        .frame(width:400, height: 5)
                    Group{
                        Text("Beneficial for :")
                            .font(.title3)
                        Text("+ Headache")
                            .font(.subheadline)
                            .fontWeight(.light)
                        Text("+ Pain")
                            .font(.subheadline)
                            .fontWeight(.light)
                        Text("+ Fever")
                            .font(.subheadline)
                            .fontWeight(.light)
                    }
                    .padding(.leading, 40)
                    Rectangle()
                        .fill(Color.gray3)
                        .frame(width:400, height: 5)
                    Group{
                        Text("Fab_Date & Exp_Date")
                            .font(.title3)
                        Text("10/05/2022  ->  10/04/2025")
                            .font(.subheadline)
                            .fontWeight(.light)
                    }
                    .padding(.leading, 40)
                    Rectangle()
                        .fill(Color.gray3)
                        .frame(width:400, height: 5)
                    Group{
                        Text("Quantity")
                            .font(.title3)
                        Text("3 packets")
                            .font(.subheadline)
                            .fontWeight(.light)
                            .underline()
                    }
                    .padding(.leading, 40)
                    Rectangle()
                        .fill(Color.gray3)
                        .frame(width:400, height: 5)
                }
                HStack{
                    ZStack{
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(Color.primarycolor, lineWidth: 2)
                            .frame(width: 235, height: 50)
                        Stepper(value: $quantity, in: 0...3,step: 1){
                            Text("Quantity: \(quantity)")
                                .foregroundColor(.primarycolor)
                        }
                        .padding()
                        .frame(width: 220)
                    }
                    Button(action: {
                        dismiss()
                    }, label: {
                        ZStack{
                            RoundedRectangle(cornerRadius: 15)
                                .foregroundStyle(Color.primarycolor)
                                .frame(width: 100, height: 40, alignment: .center)
                            HStack{
                                Text("Done")
                                    .fontWeight(.medium)
                                    .foregroundColor(.white)
                            }
                        }
                    })
                }
            }
        }
    }
}
#Preview {
    requestmedicineinfo()
}
