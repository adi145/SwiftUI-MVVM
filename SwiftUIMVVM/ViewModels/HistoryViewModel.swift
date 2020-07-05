//
//  HistoryViewModel.swift
//  SampleSwiftUIDemo
//
//  Created by Adinarayana Machavarapu on 2/7/2563 BE.
//  Copyright © 2563 Adinarayana Machavarapu. All rights reserved.
//

import Foundation

class HistoryViewModel: ObservableObject {
    
    var apimanager = Apimanager()
    @Published var showActivityIndicator: Bool = false
    @Published var bookedMoviesList = [HistoryModel.BookedMovie]()
    
    func getBookedMoviesList() {
        self.showActivityIndicator = true
       let userid = String(KeyChain.getUserId())
        apimanager.getMethod(url: Constants.Apiurl.bookMovieUrl + "/" + userid, success: { (jsonData) in
                do {
                    let results = try JSONDecoder().decode(HistoryModel.BookedMoviesList.self, from: jsonData)
                    print("results",results.data)
                    DispatchQueue.main.async {
                        self.bookedMoviesList = results.data
                        self.showActivityIndicator = false
                    }
                } catch {
                    self.hideActivityIndicator()
                    print(error)
                }
        }) { (error) in
            print("moviles list",error ?? "")
            self.hideActivityIndicator()
        }
    }
    
    func hideActivityIndicator() {
        DispatchQueue.main.async {
            self.showActivityIndicator = false
        }
    }
}

