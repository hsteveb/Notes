//
//  SwiftUIResponderListener.swift
//  Notes
//
//  Created by Hector Barrios on 1/25/21.
//

import Foundation
import Combine

class SwiftUIResponderListener: ObservableObject {
    @Published var tag: Int?
    @Published var id: Int?
    
    
    func changeTag(tag: Int, id: Int) {
        self.tag = tag
        self.id = id
    }
}
