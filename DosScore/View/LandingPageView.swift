//
//  LandingPageView.swift
//  DosScore
//
//  Created by Romain Poyard on 02/05/2023.
//

import SwiftUI
import CoreData

struct LandingPageView: View {
    
    @Binding var isShowingFirstPage: Bool
    var body: some View {
        
        
        VStack {
            Image("landingPageImage")
                .ignoresSafeArea()
                .frame(minWidth: 430)
            
            Image("Logo")
                
            Text("Gardez vos amis et concentrez vous sur ce qui compte : gagner!")
                .poppinsItalic16TextColor()
                .padding(40)
                .multilineTextAlignment(.center)
                
            Button{
                isShowingFirstPage.toggle()
            }label: {
                MyButtonLabelView(buttonText: "Commencer", color: .textColor, textSize: 18)
            }
            Spacer()
        }
        .background(BackgroundDarkModeView())
        
    }
}

struct LandingPageView_Previews: PreviewProvider {
    static var previews: some View {
        LandingPageView(isShowingFirstPage: .constant(true))
    }
}
