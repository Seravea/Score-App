//
//  MyBackButtonWithTitleView.swift
//  DosScore
//
//  Created by Romain Poyard on 04/05/2023.
//

import SwiftUI

struct MyBackButtonWithTitleView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var nav: NavigationManager
    var title: String
    var body: some View {
        HStack {
            Button {
                
                nav.goBack()
            }label: {
                Image(systemName: "chevron.left")
                    .frame(width: 45, height: 45)
                    .foregroundColor(.textColor)
                    .font(.title2)
                    
                   
            }
            
            TitleView(isJustTitle: false, title: title)
                .padding(.trailing, 45)
        
    }
        .padding(.top, 15)
        
    }
}

struct MyBackButtonWithTitleView_Previews: PreviewProvider {
    static var previews: some View {
        MyBackButtonWithTitleView(title: "Test")
    }
}
