//
//  CustomTextField.swift
//  Notes
//
//  Created by Hector Barrios on 1/13/21.
//

import SwiftUI

struct CustomTextField: UIViewRepresentable {
    
    @Binding var text: String
    @EnvironmentObject var tagResponder: SwiftUIResponderListener
    
    private let title: String
    private let isSecure: Bool
    private let tag: Int
    private let id: Int
    private let keyboardType: UIKeyboardType
    private let returnKeyType: UIReturnKeyType
    
    init(title: String = "", text: Binding<String> = .constant("") , secureTextField: Bool = false, tag: Int = 0, id: Int = 0, keyboardType: UIKeyboardType = .default, returnKeyType: UIReturnKeyType = .default) {
        self.title = title
        self._text = text
        self.isSecure = secureTextField
        self.tag = tag
        self.id = id
        self.keyboardType = keyboardType
        self.returnKeyType = returnKeyType

    }
    
    func makeUIView(context: Context) -> UITextField {
        let textfield = UITextField()
        textfield.placeholder = self.title
        textfield.tag = self.tag
        textfield.isSecureTextEntry = self.isSecure
        textfield.borderStyle = .roundedRect
        textfield.font = UIFont.preferredFont(forTextStyle: .title3)
        textfield.adjustsFontForContentSizeCategory = true
        textfield.delegate = context.coordinator
        textfield.layer.borderWidth = 1
        textfield.layer.cornerRadius = 6.0
        textfield.layer.borderColor = UIColor.clear.cgColor
        textfield.keyboardType = self.keyboardType
        textfield.returnKeyType = self.returnKeyType
        return textfield
    }
    
    func updateUIView(_ textField: UITextField, context: Context) {
        if textField.returnKeyType != .default && self.tagResponder.tag == tag && self.tagResponder.id == self.id {
            //print("Changing first responder")
            textField.becomeFirstResponder()
        }
    }

    
    func makeCoordinator() -> Coordinator {
        Coordinator(customTextField: self)
    }
    
    class Coordinator: NSObject, UITextFieldDelegate {
        
        private var customTextField: CustomTextField
        private let animationDuration = 0.15
        
        init(customTextField: CustomTextField) {
            self.customTextField = customTextField
        }
        
        /*changes the opacity so that the border can be visible*/
        func textFieldDidBeginEditing(_ textField: UITextField) {
            //print("textFieldDidBeginEditing")
            self.animateBorder(textField: textField, fromColor: UIColor.clear, toColor: UIColor.systemBlue)
        }
        
        
        func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
            if let text = textField.text {
                self.customTextField.text = text
            }
            return true
        }
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            //print("textFieldShouldReturn")
            if textField.tag != 0 && self.customTextField.id != 0 {
                self.customTextField.tagResponder.changeTag(tag: textField.tag + 1, id: self.customTextField.id)
            }
            
            if textField.returnKeyType == .done || textField.returnKeyType == .default {
                //print("Dismissing Keyboard.")
                textField.resignFirstResponder()
            }

            return true
        }
        
        /* changes the opacity so that the border turns invisible*/
        func textFieldDidEndEditing(_ textField: UITextField) {
            self.animateBorder(textField: textField, fromColor: UIColor.systemBlue, toColor: UIColor.clear)
        }
        
        func animateBorder(textField: UITextField, fromColor: UIColor, toColor: UIColor) {
            let animation = CABasicAnimation(keyPath: "borderColor")
            animation.fromValue = fromColor.cgColor
            animation.toValue = toColor.cgColor
            animation.duration = self.animationDuration
            textField.layer.add(animation, forKey: "borderColor")
            textField.layer.borderColor = toColor.cgColor
        }
        
    }
    
}
