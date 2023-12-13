//
//  MyTextFieldView.swift
//  DosScore
//
//  Created by Romain Poyard on 02/05/2023.
//

import SwiftUI

struct MyTextFieldView: View {
    
    @Binding var textFieldText: String
    var promptText: String
    
    var body: some View {
        VStack(spacing: 5) {
            Text(promptText)
                .regulartPoppins14TextColor()
            TextField("", text: $textFieldText)
                .padding(10)
                .foregroundColor(.white)
                .font(.custom("Poppins-Regular", size: 14))
                .overlay {
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color("textColor"),lineWidth: 1.5)
                        
                }
                //.frame(width: 250)
               // .padding(.horizontal)
        }
    }
}

struct MyTextFieldView_Previews: PreviewProvider {
    static var previews: some View {
        MyTextFieldView(textFieldText: .constant("kikoooooo"), promptText: "bonjour")
    }
}
