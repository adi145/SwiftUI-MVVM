//
//  LoginModel.swift
//  SampleSwiftUIDemo
//
//  Created by Adinarayana Machavarapu on 29/6/2563 BE.
//  Copyright © 2563 Adinarayana Machavarapu. All rights reserved.
//

import Foundation

struct LoginModel {
    
    struct LoginRequest {
        let username:String
        let password: String
    }
   
    struct LoginResponse: Codable {
        let message: String?
        let data: UserData
    }

    // MARK: - DataClass
    struct UserData: Codable, Identifiable {
        let id: Int
        let name, email, mobileNumber, password: String
        let companyName, address: String

        enum CodingKeys: String, CodingKey {
            case id, name, email
            case mobileNumber = "mobile_number"
            case password
            case companyName = "company_name"
            case address
        }
    }
}
