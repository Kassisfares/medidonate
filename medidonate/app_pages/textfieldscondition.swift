//
//  textfieldscondition.swift
//  medidonate
//
//  Created by fares kassis on 15/4/2024.
//

import SwiftUI

struct textfieldscondition: View {
    @State var Textfield: String = ""
    @State var Answer: String = "Test"
    @State var ShowButton: Bool = false
    @State var TextFieldVal: Bool = false
        
    var body: some View {
            VStack{
                Text(Answer)
                    .frame(width: 400, height: 40, alignment: .center)
                    .font(.title)
                    .foregroundColor(Color.black)
                
                
                TextField("Type here you answer...", text: $Textfield)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(width: 250, height: 40, alignment: .center)
                    .foregroundColor(.red)
                    .font(.headline)
                Button {
                    
                    if TextFieldVal == true {
                        ShowButton = true
                        Answer = "That is Correct!"
                    } else {
                        
                        Answer = "That is not correct"
                    }
                    
                    
                } label: {
                    Text("Send")
                        .frame(width: 250, height: 40)
                        .background(Color(red: 0.272, green: 0.471, blue: 0.262))
                        .cornerRadius(20)
                        .foregroundColor(.white)
                        .font(.headline)
                    if ShowButton {
                        NavigationLink(
                            destination: conversation(),
                            
                            label: {
                                    Text("Next")
                                        .frame(width: 120, height: 40)
                                        .background(Color.red)
                                        .cornerRadius(20)
                                        .shadow(radius: 10)
                                        .overlay(
                                    Text("Verder")
                                        .foregroundColor(.white)
                                        
                                        
                                    )}
                        )}
                }
                
            }
            .onChange(of: Textfield) { _ in
                if Textfield == " " {
                    TextFieldVal = false
                } else {
                    TextFieldVal = true
                }
            }
            
            
        }
}
#Preview {
    textfieldscondition()
}
