
//
//  ContentView.swift
//  SampleSwiftUIDemo
//
//  Created by Adinarayana Machavarapu on 26/6/2563 BE.
//  Copyright © 2563 Adinarayana Machavarapu. All rights reserved.
//

import SwiftUI

struct LoginView: View{

    @ObservedObject var viewModel: LoginViewModel
    @State var username: String = ""
    @State var password: String = ""
    @EnvironmentObject var settings : UserSettings

    @ViewBuilder
    var body: some View {
        if checkUserLogin() == true{
          navigateToHomeScreen()
        } else {
          returnLoginView()
        }
    }
    
    func checkUserLogin() -> Bool {
        let userlogin = SaveUser.get(key: SaveUser.login_username)
        print(userlogin)
        if userlogin != "" {
            return true
        } else {
            return false
        }
    }

    func navigateToHomeScreen() -> some View {
        var body: some View {
            NavigationView{
                VStack(){
                    NavigationLink(destination: Home(), isActive: self.$settings.isNavigateToHomeScreen) { EmptyView() }
                }
            }
        }
        return body
    }
    
    func returnLoginView() -> some View {
        var body: some View {
            NavigationView{
                ZStack {
                    Color(.systemTeal)
                        .edgesIgnoringSafeArea(.all)
                    VStack(){
                        self.signupNavigation
                        Spacer()
                        VStack(alignment: .center) {
                            CircleImageView(width: 150.0, heigh: 150.0, imageName: "cimblogo")
                        }
                        Spacer().frame(width: 0, height: 80.0, alignment: .bottom)
                        ActivityIndicator(isAnimating: .constant(self.viewModel.showActivityIndicator), style: .large)
                        VStack(alignment: .leading){
                            CustomTextField(textfilevalue: self.$username, placeholderText: "Username")
                            CustomPasswordTextField(textfilevalue: self.$password, placeholderText: "Password")
                            Spacer().frame(width: 0, height: 20.0, alignment: .topLeading)
                            CustomeButton(onAction: {
                                self.viewModel.loginVlidation(username: self.username, password: self.password)
                            }, buttonName: "Login", backGroundColor: Color.white, textColor: Color.black)
                            Spacer().frame(width: 0, height: 10.0, alignment: .topLeading)
                            VStack() {
                               AnyView(signupButton)
                            }
                        }
                        Spacer()
                        Spacer()
                        Spacer()
                    }
                }.navigationBarTitle("SwiftUI", displayMode: .inline)
                    .navigationBarHidden(self.settings.ishideNavigationBar)
                    .alert(isPresented: self.$viewModel.loginValidation, content: { self.loginValidationAlert })
                    .modifier(AdaptsToSoftwareKeyboard())
            }.onAppear() {
                self.settings.ishideNavigationBar = true
                self.settings.isNavigateToHomeScreen = true
                self.settings.isNavigateToSignupScreen = false
                self.username = ""
                self.password = ""
                
//                let username = "Adi2513"
//                let data = Data(from: username)
//                KeyChain.save(key: "username", data: data)
//
//                if let receivedData = KeyChain.load(key: "username") {
//                    let result = receivedData.to(type: String.self)
//                    print("result: ", result)
//                }
//                if let receivedData = KeyChain.load(key: "username") {
//                                let result = receivedData.to(type: String.self)
//                                print("result: ", result)
//                            }
//                KeyChain.remove(key: "username")
//
//                if let receivedData = KeyChain.load(key: "username") {
//                    let result = receivedData.to(type: String.self)
//                    print("result: ", result)
//                }
                
            }.onDisappear() {
                
            }
        }
        return body
    }
    var signupNavigation : some View {
         NavigationLink(destination: SingupView(viewModel: SingupViewModel()), isActive: self.$settings.isNavigateToSignupScreen) {
            Text("")
        }
    }

    var signupButton: some View {
        Button(action: {
            self.settings.isNavigateToSignupScreen = true
        }) {
            Text("Don't have account? Singup").foregroundColor(Color.white)
        }.frame(width: UIScreen.main.bounds.width-40, height: 30, alignment: .center)
    }
    
    var loginValidationAlert: Alert {
        Alert(title: Text(""), message: Text("Please enter username & password"), dismissButton: .default(Text("Dismiss")))
    }

    
    func validateUsernameAndPassword(username: String, password: String){
        self.viewModel.loginVlidation(username: username, password: password)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
       return LoginView(viewModel: LoginViewModel())
    }
}






