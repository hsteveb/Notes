//
//  CreateAccountWithEmail.swift
//  Notes
//
//  Created by Hector Barrios on 1/5/21.
//

import SwiftUI
import Combine

struct EmailAccountCreationView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var tagResponder: SwiftUIResponderListener

    @Binding var isPresent: Bool
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var passwordConfirmation: String = ""
    @State private var showProgress = false
    
    init(isPresent: Binding<Bool> = Binding.constant(false)) {
        self._isPresent = isPresent
    }
    
    private var fieldSpacing: CGFloat = 5.0
    private let viewId = 2
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .top) {
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 10) {
                        HeaderView(parentHeight: geometry.size.height)
                        Group {
                            VStack(spacing: 10.0) {
                                /*Email*/
                                VStack(alignment: .leading, spacing: self.fieldSpacing){
                                    Text("Email")
                                        .font(.headline)
                                    CustomTextField(tag: 1, id: self.viewId, keyboardType: .emailAddress, returnKeyType: .next)
                                }
                                
                                /*Password*/
                                VStack(alignment: .leading, spacing: self.fieldSpacing){
                                    Text("Password")
                                        .font(.headline)
                                    CustomTextField(tag: 2, id: self.viewId, returnKeyType: .next)
                                }
                                
                                /*Retype Password*/
                                VStack(alignment: .leading, spacing: self.fieldSpacing){
                                    Text("Re-type Password")
                                        .font(.headline)
                                    CustomTextField(tag: 3, id: self.viewId, returnKeyType: .done)
                                }
                            }
                        }
                        .fixedSize(horizontal: false, vertical: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
                        .frame(width: geometry.size.width/1.2, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        
                        LoginButtons(parentWidth: geometry.size.width, text: "Sign up") {
                            print("EmailAccountCreationView Height: \(geometry.size.height)")
                        }
                        .foregroundColor(.white)
                        .background(Color("facebook_blue"))
                        .cornerRadius(6.0)
                    }
                    
                }
                .frame(width: geometry.size.width, height: geometry.size.height, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                
                /*Custom navigationview at the top*/
                ZStack(alignment: .center) {
                    HStack {
                        Button(action: { withAnimation {
                            self.isPresent.toggle()
                        }
                        }, label: {
                            
                            HStack(spacing: 0) {
                                Image(systemName: "chevron.backward")
                                Text("Back")
                            }
                            .padding(.trailing)
                            .padding(.bottom)
                            .padding(.top)
                            .font(.body)
                        })
                        Spacer()
                    }
                    Text("Create Account")
                }
                .background(Color.black)
                .padding(.leading, /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                .padding(.trailing, 10)
            }
        }
    }
}

struct EmailAccountCreationView_Previews: PreviewProvider {
    static var previews: some View {
        EmailAccountCreationView(isPresent: Binding.constant(false))
    }
}
