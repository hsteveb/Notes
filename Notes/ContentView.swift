//
//  ContentView.swift
//  Notes
//
//  Created by Hector Barrios on 12/22/20.
//

import SwiftUI
import CoreData
import AuthenticationServices
import FacebookLogin

struct ContentView: View {

    @Environment(\.colorScheme) var colorScheme
    @State var username: String = ""
    @State var password: String = ""
    @State var showModal = false
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>

    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 0) {
                
                HeaderView(parentHeight: geometry.size.height)
                
                Spacer()
                
                /*Facebook Button*/
                VStack(spacing: 12.0) {
                LoginButtons(parentWidth: geometry.size.width, text: "Login with Facebook") {
                    print("Testing")
                    print("ContentView Height: \(geometry.size.height)")
                }
                .foregroundColor(.white)
                .background(Color("facebook_blue"))
                .cornerRadius(6.0)

                /*Apple sign in button*/
                SignInWithAppleButton(.signIn) { request in
                    request.requestedScopes = [.fullName, .email]
                } onCompletion: { (result) in
                    switch result {
                    case .success(let authorization):
                        print("successful login")
                        print(authorization)
                        //let info = authorization.credential as? ASAuthorizationAppleIDCredential
                                                
                        //print("Email: \(info?.email)")
                        //print("User: \(info?.user)")
                                                
                    default:
                        print("unsuccessful login")
                    }
                }
                .frame(width: geometry.size.width/1.2, height: 40, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .signInWithAppleButtonStyle(self.colorScheme == .dark ? .white : .black)
                
                /*Regular Email sign in*/
                LoginButtons(parentWidth: geometry.size.width, text: "Login with Email") {
                    self.showModal.toggle()
                }
                .foregroundColor(self.colorScheme == .dark ? .black : .white)
                .background(self.colorScheme == .dark ? Color.white : Color.black)
                .cornerRadius(6.0)
                .fullScreenCover(isPresented: $showModal, content: {
                    EmailLoginView().environmentObject(SwiftUIResponderListener())
                })
                }
                Spacer()
            }
            .frame(width: geometry.size.width, height: geometry.size.height, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
