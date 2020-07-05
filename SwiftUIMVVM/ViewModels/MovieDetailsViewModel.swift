//
//  MovieDetailsViewModel.swift
//  SampleSwiftUIDemo
//
//  Created by Adinarayana Machavarapu on 1/7/2563 BE.
//  Copyright © 2563 Adinarayana Machavarapu. All rights reserved.
//

import Foundation

class MovieDetailsViewModel: ObservableObject {
    var apimanager = ApiManager()
    @Published var showActivityIndicator = false
    @Published var bookedTicketConfirm: Bool = false

    func bookMovie(movieId : String) {
       
        self.showActivityIndicator = true
        var userid = ""
        guard let userId = UserDefaults.standard.value(forKey: "login_id") as? Int else {
                return
        }
        userid = String(userId)
        let params = ["user_id" : userid, "movie_id" : movieId]
        apimanager.postAction(url: Constants.Apiurl.bookMovieUrl, param: params, aSuccess: { (data) in
            DispatchQueue.main.async {
               self.bookedTicketConfirm = true
            }
        }, aFailure: { (errormessage) in
            print(errormessage)
            DispatchQueue.main.async {
                self.bookedTicketConfirm = false
                self.showActivityIndicator = false
            }
        })
    }
}
