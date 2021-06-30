//
//  HeaderView.swift
//  Notes
//
//  Created by Hector Barrios on 1/5/21.
//

import SwiftUI

struct HeaderView: View {
    let parentHeight: CGFloat
    
    var body: some View {
        VStack {
            Color.clear.frame(height: parentHeight / 4)
            Text("Notes")
                        .font(.custom("", size: 75, relativeTo: .largeTitle))
        }

    }
}

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderView(parentHeight: 100.0)
    }
}
