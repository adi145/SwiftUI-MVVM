//
//  SingupViewModel.swift
//  SampleSwiftUIDemo
//
//  Created by Adinarayana Machavarapu on 30/6/2563 BE.
//  Copyright © 2563 Adinarayana Machavarapu. All rights reserved.
//

import Foundation
import SwiftUI

class SingupViewModel: ObservableObject {
    var apimanager = Apimanager()
    @Published var showActivityIndicator: Bool = false
    @Published var singupValidation: Bool = false
    @Published var singupSuccess: Bool = false
    var signupPlaceHolderList = ["Firstname","Lastname","Email","Mobile number","Company name","Address","Password","Confirm password"]
    @Published var signupData = ["","","","","","","",""]
    
    func signupVlidation(signupList:[String]){
        if signupList[0] != "" && signupList[7] != "" {
            let request = SingupModel.SignupRequest(name: signupList[0] + " " + signupList[1], email: signupList[2], mobileNumber: signupList[3], password: signupList[7], companyName: signupList[4], address: signupList[5])
            self.singupValidation = false
            self.signupRequest(request: request)
        } else {
            self.singupValidation = true
        }
    }

    func signupRequest(request: SingupModel.SignupRequest) {
        self.showActivityIndicatorCallingApi()
        let parameterDictionary = ["name":request.name, "email" : request.email, "password" : request.password, "mobile_number":request.mobileNumber, "company_name":request.companyName, "address": request.address]
        apimanager.postAction(url: Constants.Apiurl.baseUrl + Constants.Apiurl.signupUrl, param: parameterDictionary, success: { (data) in
            DispatchQueue.main.async {
                 self.singupSuccess = true
                self.hideActivityIndicator()
            }
        }, failure: { (errormessage) in
            print("Singup error message",errormessage ?? "")
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
