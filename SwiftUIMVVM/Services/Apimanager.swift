//
//  ApiManager.swift
//  SampleSwiftUIDemo
//
//  Created by Adinarayana Machavarapu on 29/6/2563 BE.
//  Copyright © 2563 Adinarayana Machavarapu. All rights reserved.
//

import Foundation

public enum RequestMethod: String {
     case get = "GET"
     case post = "POST"
     case put = "PUT"
     case delete = "DELETE"
 }

class Apimanager {
    typealias successCompletionHandler = (_ data:Data) -> ()
    typealias failureCompletionHandler = (_ error: String?) -> ()
    
    func getMethod(url:String, success: @escaping successCompletionHandler, aFailure: @escaping failureCompletionHandler) {
         if let url = URL(string: url) {
             let session = URLSession(configuration: .default)
             let task = session.dataTask(with: url) { (data, response, error) in
                 if error == nil {
                    if let jsonData = data {
                           do {
                               // make sure this JSON is in the format we expect
                               if let json = try JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: Any] {
                                   // try to read out a string array
                                   print("Get json ++++++++++++++++++++++",json)
                                   success(data ?? Data())
                               }
                           } catch let error as NSError {
                               print("Failed to load: \(error.localizedDescription)")
                           }
                         }
                 } else {
                    aFailure(error?.localizedDescription)
                }
             }
             task.resume()
         }
     }
    
    func postAction(url:String, param:[String:Any]?, success: @escaping successCompletionHandler, failure: @escaping failureCompletionHandler) {
        let Url = String(format: url)
        guard let serviceUrl = URL(string: Url) else { return }
        var request = URLRequest(url: serviceUrl)
        request.httpMethod = RequestMethod.post.rawValue
        request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        guard let httpBody = try? JSONSerialization.data(withJSONObject: param!, options: []) else {
            return
        }
        request.httpBody = httpBody

        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            if error == nil {
                if let jsonData = data {
                do {
                    // make sure this JSON is in the format we expect
                    if let json = try JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: Any] {
                        // try to read out a string array
                        print("json ++++++++++++++++++++++",json)
                        success(data ?? Data())
                    }
                } catch let error as NSError {
                    print("Failed to load: \(error.localizedDescription)")
                }
              }
            } else {
                failure(error?.localizedDescription)
            }
            }.resume()
    }
}
