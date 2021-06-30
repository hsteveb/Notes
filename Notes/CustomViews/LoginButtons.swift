//
//  LoginButtons.swift
//  Notes
//
//  Created by Hector Barrios on 6/11/21.
//

import SwiftUI

struct LoginButtons: View {
    let parentWidth: CGFloat
    let text: String
    let action : () -> Void
    var body: some View {
        Button(action: action, label: {
            Text(self.text)
                .frame(width: parentWidth/1.2, height: 40, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .font(.title2)
        })
        
    }
}

struct LoginButtons_Previews: PreviewProvider {
    static var previews: some View {
        LoginButtons(parentWidth: 100, text: "Hello") {
            
        }
    }
}
