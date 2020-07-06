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
            let request = LoginModel.LoginRequest(email: username, password: password)
            self.showActivityIndicator = true
            self.loginValidation = false
            self.login(request: request)
        } else {
            self.showActivityIndicator = false
            self.loginValidation = true
        }
    }
    
    func login(request: LoginModel.LoginRequest) {
        self.showActivityIndicator = true
        let parameterDictionary = ["email" : request.email, "password" : request.password]
        apimanager.postAction(url: Constants.Apiurl.baseUrl + Constants.Apiurl.loginUrl, param: parameterDictionary, success: { (jsondata) in
                do {
                    let results = try JSONDecoder().decode(LoginModel.LoginResponse.self, from: jsondata)
                    print("results",results)
                    
                    DispatchQueue.main.async {
                        self.loginResponse = results
                        SaveUser.save(key: SaveUser.login_username, value: self.loginResponse.data.name)
                        SaveUser.save(key: SaveUser.login_user_id, value: String(self.loginResponse.data.id))
                        self.showActivityIndicator = false
                    }
                } catch {
                    self.hideActivityIndicator()
                    print("login error +++++++++")
                }
        }, failure: { (errormessage) in
            print("login error message",errormessage ?? "")
            self.hideActivityIndicator()
        })
    }

    func getUserProfileData() {
        self.showActivityIndicatorCallingApi()
        apimanager.getMethod(url: Constants.Apiurl.baseUrl + Constants.Apiurl.getUserProfileUrl + "/" + SaveUser.getUserId(), success: { (jsonData) in
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
                   // self.showActivityIndicator = false
                    self.hideActivityIndicator()
                }
            } catch {
                self.hideActivityIndicator()
                print(error)
            }
        }) { (error) in
            self.hideActivityIndicator()
            print("moviles list",error ?? "")
        }
    }
    
    func profileUpdate() {
        self.showActivityIndicator = true
        let parameterDictionary = ["name":self.userProfileData[0], "email" : self.userProfileData[1], "mobile_number":self.userProfileData[2], "password" : self.loginResponse.data.password,"company_name":self.userProfileData[3],"address":self.userProfileData[4]]
        apimanager.postAction(url: Constants.Apiurl.baseUrl + Constants.Apiurl.updateUserProfileUrl + SaveUser.getUserId(), param: parameterDictionary, success: { (jsonData) in
                do {
                    let results = try JSONDecoder().decode(LoginModel.LoginResponse.self, from: jsonData)
                    print("results",results)
                    self.getUserProfileData()
                } catch {
                    print(error)
                    self.hideActivityIndicator()
                }
        }, failure: { (errormessage) in
            print("login error message",errormessage ?? "")
            self.hideActivityIndicator()
        })
    }
    
    func showActivityIndicatorCallingApi() {
        self.showActivityIndicator = true
    }
    func hideActivityIndicator() {
        DispatchQueue.main.async {
            self.showActivityIndicator = false
        }
    }
}
