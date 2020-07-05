//
//  LoginViewModel.swift
//  SampleSwiftUIDemo
//
//  Created by Adinarayana Machavarapu on 29/6/2563 BE.
//  Copyright © 2563 Adinarayana Machavarapu. All rights reserved.
//

import SwiftUI

class LoginViewModel: ObservableObject {
    
    var apimanager = Apimanager()
    @Published var loginResponse = LoginModel.LoginResponse(message: "", data: LoginModel.UserData(id: -1, name: "", email: "", mobileNumber: "", password: "", companyName: "", address: ""))
    @Published var showActivityIndicator: Bool = false
    @Published var loginValidation: Bool = false
    var userProfilePlaceHolderList = ["User name", "Email", "Mobile number","Company name", "Address"]
    @Published var userProfileData = ["", "", "","", ""]

    func loginVlidation(username:String, password:String){
        if username != "" && password != "" {
            let request = LoginModel.LoginRequest(username: username, password: password)
            self.showActivityIndicator = true
            self.loginValidation = false
            self.login(request: request)
        } else {
            self.showActivityIndicator = false
            self.loginValidation = true
        }
    }
    
    func login(request: LoginModel.LoginRequest?) {
        self.showActivityIndicator = true
        let parameterDictionary = ["email" : request!.username, "password" : request!.password]
        apimanager.postAction(url: Constants.Apiurl.loginUrl, param: parameterDictionary, success: { (jsondata) in
                do {
                    let results = try JSONDecoder().decode(LoginModel.LoginResponse.self, from: jsondata)
                    print("results",results)
                    
                    DispatchQueue.main.async {
                        self.loginResponse = results
                        UserDefaults.standard.set(self.loginResponse.data.name, forKey: "login")
                        UserDefaults.standard.set(self.loginResponse.data.id, forKey: "login_id")
                        self.showActivityIndicator = false
                    }
                } catch {
                    DispatchQueue.main.async {
                        self.showActivityIndicator = false
                    }
                    print("login error +++++++++")
                }
        }, failure: { (errormessage) in
            print("login error message",errormessage ?? "")
            DispatchQueue.main.async {
                self.showActivityIndicator = false
            }
        })
    }

    func getUserProfileData() {
        self.showActivityIndicator = true
        
        apimanager.getMethod(url: Constants.Apiurl.getUserProfileUrl + "/" + String(KeyChain.getUserId()), success: { (jsonData) in
            do {
                let results = try JSONDecoder().decode(LoginModel.LoginResponse.self, from: jsonData)
                print("results",results.data)
                DispatchQueue.main.async {
                    self.loginResponse = results
                    self.userProfileData.removeAll()
                    self.userProfileData.append(results.data.name)
                    self.userProfileData.append(results.data.email)
                    self.userProfileData.append(results.data.mobileNumber)
                    self.userProfileData.append(results.data.companyName)
                    self.userProfileData.append(results.data.address)
                    self.showActivityIndicator = false
                }
            } catch {
                print(error)
            }
        }) { (error) in
            print("moviles list",error ?? "")
            self.showActivityIndicator = false
        }
    }
    
    func profileUpdate() {
        self.showActivityIndicator = true
        let parameterDictionary = ["name":self.userProfileData[0], "email" : self.userProfileData[1], "mobile_number":self.userProfileData[2], "password" : self.loginResponse.data.password,"company_name":self.userProfileData[3],"address":self.userProfileData[4]]
        apimanager.postAction(url: Constants.Apiurl.updateUserProfileUrl + String(KeyChain.getUserId()), param: parameterDictionary, success: { (jsonData) in
                do {
                    let results = try JSONDecoder().decode(LoginModel.LoginResponse.self, from: jsonData)
                    print("results",results)
                    self.getUserProfileData()
                } catch {
                    print(error)
                }
        }, failure: { (errormessage) in
            print("login error message",errormessage ?? "")
            DispatchQueue.main.async {
                self.showActivityIndicator = false
            }
        })
    }
}
