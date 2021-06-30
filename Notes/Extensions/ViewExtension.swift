//
//  ViewExtension.swift
//  Notes
//
//  Created by Hector Barrios on 1/31/21.
//

import SwiftUI

extension View {
    func dismissKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
