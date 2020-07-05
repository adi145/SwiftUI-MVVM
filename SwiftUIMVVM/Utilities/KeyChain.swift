//
//  KeyChain.swift
//  SwiftUIMVVM
//
//  Created by Adinarayana on 05/07/20.
//  Copyright © 2020 Adinarayana Machavarapu. All rights reserved.
//

import Foundation

import Security

class KeyChain {

   //    class func save(key: String, data: Data) -> OSStatus {
    class func save(key: String, data: Data) {
        let query = [
            kSecClass as String       : kSecClassGenericPassword as String,
            kSecAttrAccount as String : key,
            kSecValueData as String   : data ] as [String : Any]

        SecItemDelete(query as CFDictionary)
        SecItemAdd(query as CFDictionary, nil)
       // return SecItemAdd(query as CFDictionary, nil)
    }

    class func load(key: String) -> Data? {
        let query = [
            kSecClass as String       : kSecClassGenericPassword,
            kSecAttrAccount as String : key,
            kSecReturnData as String  : kCFBooleanTrue!,
            kSecMatchLimit as String  : kSecMatchLimitOne ] as [String : Any]

        var dataTypeRef: AnyObject? = nil

        let status: OSStatus = SecItemCopyMatching(query as CFDictionary, &dataTypeRef)

        if status == noErr {
            return dataTypeRef as! Data?
        } else {
            return nil
        }
    }
    class func remove(key: String) {
        // Instantiate a new default keychain query
        
        let query = [
                kSecClass as String       : kSecClassGenericPassword as String,
                kSecAttrAccount as String : key] as [String : Any]

         let status = SecItemDelete(query as CFDictionary)
        
        if (status != errSecSuccess) {
                   if let err = SecCopyErrorMessageString(status, nil) {
                       print("Remove failed: \(err)")
                   }
               }
        
    }
    class func createUniqueID() -> String {
        let uuid: CFUUID = CFUUIDCreate(nil)
        let cfStr: CFString = CFUUIDCreateString(nil, uuid)

        let swiftString: String = cfStr as String
        return swiftString
    }
    class func getUserId() -> Int {
        if let receivedData = KeyChain.load(key: "login_id") {
            let userId = receivedData.to(type: Int.self)
            print("result: ", userId)
            return userId
        }
        return -1
    }
    
}

extension Data {

    init<T>(from value: T) {
        var value = value
        self.init(buffer: UnsafeBufferPointer(start: &value, count: 1))
    }

    func to<T>(type: T.Type) -> T {
        return self.withUnsafeBytes { $0.load(as: T.self) }
    }
}
