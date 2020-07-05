//
//  HistoryViewModel.swift
//  SampleSwiftUIDemo
//
//  Created by Adinarayana Machavarapu on 2/7/2563 BE.
//  Copyright © 2563 Adinarayana Machavarapu. All rights reserved.
//

import Foundation

class HistoryViewModel: ObservableObject {
    
    var apimanager = ApiManager()
    @Published var showActivityIndicator: Bool = false
    @Published var bookedMoviesList = [HistoryModel.BookedMovie]()
    
    func getBookedMoviesList() {
        self.showActivityIndicator = true
        var userid = ""
        guard let userId = UserDefaults.standard.value(forKey: "login_id") as? Int else {
            return
        }
        userid = String(userId)
        apimanager.getMethod(url: Constants.Apiurl.bookMovieUrl + "/" + userid, aSuccess: { (jsonData) in
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

