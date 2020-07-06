//
//  MovieDetailsViewModel.swift
//  SampleSwiftUIDemo
//
//  Created by Adinarayana Machavarapu on 1/7/2563 BE.
//  Copyright © 2563 Adinarayana Machavarapu. All rights reserved.
//

import Foundation

class MovieDetailsViewModel: ObservableObject {
    var apimanager = Apimanager()
    @Published var showActivityIndicator = false
    @Published var bookedTicketConfirm: Bool = false

    func bookMovie(movieId : String) {
        self.showActivityIndicatorCallingApi()
        let params = ["user_id" : SaveUser.getUserId(), "movie_id" : movieId]
        apimanager.postAction(url: Constants.Apiurl.baseUrl + Constants.Apiurl.bookMovieUrl, param: params, success: { (data) in
            DispatchQueue.main.async {
               self.bookedTicketConfirm = true
            }
        }, failure: { (errormessage) in
            print("book ticket",errormessage ?? "")
            DispatchQueue.main.async {
                self.bookedTicketConfirm = false
                self.hideActivityIndicator()
            }
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
