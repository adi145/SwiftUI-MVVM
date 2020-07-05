//
//  ApiManager.swift
//  SampleSwiftUIDemo
//
//  Created by Adinarayana Machavarapu on 29/6/2563 BE.
//  Copyright © 2563 Adinarayana Machavarapu. All rights reserved.
//

import Foundation

class ApiManager {
    
    func getMethod(url:String, aSuccess: @escaping (_ data:Data) -> (), aFailure: @escaping (_ error: String?) -> ()) {
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
                                   aSuccess(data ?? Data())
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
    
    func postAction(url:String, param:[String:Any]?, aSuccess: @escaping (_ data:Data?) -> (), aFailure: @escaping (_ error: String?) -> ()) {
        let Url = String(format: url)
        guard let serviceUrl = URL(string: Url) else { return }
        var request = URLRequest(url: serviceUrl)
        request.httpMethod = "POST"
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
                        aSuccess(data ?? Data())
                    }
                } catch let error as NSError {
                    print("Failed to load: \(error.localizedDescription)")
                }
              }
                
                /* let decoder = JSONDecoder()
                 if let safeData = data {
                 do {
                 //   let results = try decoder.decode(Results.self, from: safeData)
                 DispatchQueue.main.async {
                 self.posts = results.hits
                 }
                 } catch {
                 print(error)
                 }
                 }*/
            } else {
                aFailure(error?.localizedDescription)
            }
            }.resume()
    }
    
    func postMethod(url:String, aSuccess: @escaping (_ data:Data) -> (), aFailure: @escaping (_ error: String?) -> ()) {
           if let url = URL(string: url) {
               let session = URLSession(configuration: .default)
               let task = session.dataTask(with: url) { (data, response, error) in
                   if error == nil {
                      aSuccess(data ?? Data())
                      /* let decoder = JSONDecoder()
                       if let safeData = data {
                           do {
                            //   let results = try decoder.decode(Results.self, from: safeData)
                               DispatchQueue.main.async {
                                   self.posts = results.hits
                               }
                           } catch {
                               print(error)
                           }
                       }*/
                   } else {
                      aFailure(error?.localizedDescription)
                  }
               }
               task.resume()
           }
       }
}
