//
//  EmailLogin.swift
//  Notes
//
//  Created by Hector Barrios on 1/4/21.
//

import SwiftUI

struct EmailLoginView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var tagResponder: SwiftUIResponderListener
    
    @State private var username = ""
    @State private var password = ""
    @State private var showModal = false
    private let viewId = 1
    //private let animation = Animation.easeInOut(duration: 0.3)
    
    var body: some View {
        GeometryReader { geometry in
            
            ZStack(alignment: .top) {
                
                if !self.showModal {
                    Group {
                        VStack(spacing: 0){
                            // Title used on every screen.
                            HeaderView(parentHeight: geometry.size.height)
                            
                            Spacer()
                            
                            VStack(spacing: 12.0){
                                Group {
                                    // Get email
                                    CustomTextField(title: "Email", text: self.$username, tag: 1, id: self.viewId, keyboardType: .emailAddress, returnKeyType: .next)
                                    
                                    // Get password
                                    CustomTextField(title: "Password", text: self.$password, secureTextField: true, tag: 2, id: self.viewId, returnKeyType: .done)
                                }
                                .fixedSize(horizontal: false, vertical: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
                                .frame(width: geometry.size.width/1.2, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                
                                // button to sign you in and closed this modal
                                VStack(spacing: 6) {
                                    
                                    /*Sign In Button*/
                                    LoginButtons(parentWidth: geometry.size.width, text: "Sign In") {
                                        print("username: \(self.username)")
                                        print("password: \(self.password)")
                                        print("EmailLongView Height: \(geometry.size.height)")
                                    }
                                    .foregroundColor(.white)
                                    .background(Color("facebook_blue"))
                                    .cornerRadius(6.0)
                                    
                                    // button to take you to another screen and create account
                                    Button(action: {
                                        withAnimation {
                                            self.showModal.toggle()
                                        }
                                    }, label: {
                                        Text("Create an account")
                                            .font(.body)
                                            .cornerRadius(6.0)
                                    })
                                }
                            }
                            Spacer()
                        }
                        .simultaneousGesture(TapGesture().onEnded({
                            self.tagResponder.changeTag(tag: 0, id: self.viewId)
                            self.dismissKeyboard()
                        }))
                        .frame(width: geometry.size.width, height: geometry.size.height)
                        
                        ZStack {
                            HStack(alignment: .center) {
                                Button(action: { self.presentationMode.wrappedValue.dismiss()
                                }, label: {
                                    Text("Cancel")
                                        .padding(.trailing)
                                        .padding(.bottom)
                                        .padding(.top)
                                        .font(.body)
                                })
                                Spacer()
                            }
                            Text("Email")
                                .font(.body)
                        }
                        .padding(.leading, /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                        .padding(.trailing, 10)
                    }
                    .transition(.move(edge: .leading))
                } else {
                    EmailAccountCreationView(isPresent: self.$showModal)
                        .transition(.move(edge: .trailing))
                }
            }
        }
    }
}

struct EmailLogin_Previews: PreviewProvider {
    static var previews: some View {
        EmailLoginView()
    }
}
