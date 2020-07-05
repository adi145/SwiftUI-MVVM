//
//  SingupView.swift
//  SampleSwiftUIDemo
//
//  Created by Adinarayana Machavarapu on 26/6/2563 BE.
//  Copyright © 2563 Adinarayana Machavarapu. All rights reserved.
//

import SwiftUI

struct SingupView: View {
    
    @ObservedObject var viewModel: SingupViewModel
    @EnvironmentObject var settings: UserSettings

    var body: some View {
        
        ZStack {
            List{
                Spacer().frame(width: 0, height: 20, alignment: .center)
                ForEach(0..<self.viewModel.signupData.count, id: \.self) { index in
                    VStack{
                        if index == 6 || index == 7 {
                            CustomPasswordTextField(textfilevalue: self.$viewModel.signupData[index], placeholderText: self.viewModel.signupPlaceHolderList[index])
                        } else {
                            CustomTextField(textfilevalue: self.$viewModel.signupData[index], placeholderText: self.viewModel.signupPlaceHolderList[index])
                        }
                    }
                }
                Section() {
                    CustomeButton(onAction: {
                        self.viewModel.signupVlidation(signupList: self.viewModel.signupData)
                    }, buttonName: "Signup", backGroundColor: Color(.systemTeal), textColor: Color.white)
                }
                .padding(.vertical, 10.0)
            }.modifier(AdaptsToSoftwareKeyboard())
            ActivityIndicator(isAnimating: .constant(self.viewModel.showActivityIndicator), style: .large).frame(width: UIScreen.screenWidth/2, height: UIScreen.screenHeight/2, alignment: .center)
        }
        .navigationBarTitle(Text("Signup"), displayMode: .inline)
        .navigationBarItems(leading:
            self.navigationBackButton
        ).alert(isPresented: self.$viewModel.singupValidation, content: {
            self.signupValidationAlert
        })
            .alert(isPresented: self.$viewModel.singupSuccess, content: {
                self.signupSuccessAlert
            })
            .onAppear(){
                UITableView.appearance().separatorStyle = .none
                self.settings.ishideNavigationBar = false
        }.onDisappear(){
           // print(self.viewModel.signupData)
        }
        /*
         ScrollView {
         Spacer().frame(width: 0, height: 20.0, alignment: .top)
         ActivityIndicator(isAnimating: .constant(self.viewModel.showActivityIndicator), style: .large)
         VStack {
         CustomTextField(textfilevalue: self.$textFieldListArray[0], placeholderText: self.placeHolderList[0])
         CustomTextField(textfilevalue: self.$textFieldListArray[1], placeholderText: self.placeHolderList[1])
         CustomTextField(textfilevalue: self.$textFieldListArray[2], placeholderText: self.placeHolderList[2])
         CustomTextField(textfilevalue: self.$textFieldListArray[3], placeholderText: self.placeHolderList[3])
         CustomTextField(textfilevalue: self.$textFieldListArray[4], placeholderText: self.placeHolderList[4])
         CustomTextField(textfilevalue: self.$textFieldListArray[5], placeholderText: self.placeHolderList[5])
         CustomPasswordTextField(textfilevalue: self.$textFieldListArray[6], placeholderText: self.placeHolderList[6])
         CustomPasswordTextField(textfilevalue: self.$textFieldListArray[7], placeholderText: self.placeHolderList[7])
         Spacer().frame(width: 0, height: 20.0, alignment: .topLeading)
         CustomeButton(onAction: {
         print("Book Button Tapped")
         self.viewModel.signupVlidation(signupList: self.textFieldListArray)
         }, buttonName: "Signup", backGroundColor: Color(.systemTeal), textColor: Color.white)
         
         }
         }.alert(isPresented: self.$viewModel.singupValidation, content: {
         self.signupValidationAlert
         })
         .alert(isPresented: self.$viewModel.singupSuccess, content: {
         self.signupSuccessAlert
         })
         .modifier(AdaptsToSoftwareKeyboard())
         .padding(.horizontal, 5.0)
         .navigationBarTitle(Text("Signup"), displayMode: .inline)
         .navigationBarItems(leading:
         Button(action: {
         print("User icon pressed...")
         self.isSignup = false
         self.navBarHidden = true
         }) {
         Image(systemName: "chevron.left").imageScale(.large).foregroundColor(Color.blue)
         }
         )
         .onAppear(){
         print("onAppear")
         self.navBarHidden = false
         }.onDisappear() {
         print("onDisappear")
         }*/
    }
    var navigationBackButton : some View {
        Button(action: {
            self.settings.isNavigateToSignupScreen = false
            self.settings.ishideNavigationBar = true
        }) {
            Image(systemName: "chevron.left").imageScale(.large).foregroundColor(Color.blue)
        }
    }
    var signupValidationAlert: Alert {
        Alert(title: Text(""), message: Text("Please enter username & password"), dismissButton: .default(Text("Dismiss")))
    }
    var signupSuccessAlert: Alert {
        Alert(title: Text(""), message: Text("Registered successfully"),dismissButton:.default(Text("Ok"), action: {
            self.settings.isNavigateToSignupScreen = false
            self.settings.ishideNavigationBar = true
        }))
    }
}

struct SingupView_Previews: PreviewProvider {
    static var previews: some View {
        SingupView(viewModel: SingupViewModel())
    }
}
