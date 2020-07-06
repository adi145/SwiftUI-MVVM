//
//  MoviesViewModel.swift
//  SampleSwiftUIDemo
//
//  Created by Adinarayana Machavarapu on 1/7/2563 BE.
//  Copyright © 2563 Adinarayana Machavarapu. All rights reserved.
//

import Foundation

class MoviesViewModel: ObservableObject {

    var apimanager = Apimanager()
    @Published var showActivityIndicator: Bool = false
    @Published var moviesList = [MoviesModels.Movie]()

    func getMoviesList() {
        self.showActivityIndicator = true
     
        apimanager.getMethod(url: Constants.Apiurl.baseUrl + Constants.Apiurl.moviesListUrl + "/" + SaveUser.getUserId(), success: { (jsonData) in
                do {
                    let results = try JSONDecoder().decode(MoviesModels.MoviesList.self, from: jsonData)
                    DispatchQueue.main.async {
                        self.moviesList.removeAll()
                        self.moviesList = results.data
                        self.hideActivityIndicator()
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
    
    func showActivityIndicatorCallingApi() {
        self.showActivityIndicator = true
    }
    func hideActivityIndicator() {
        DispatchQueue.main.async {
            self.showActivityIndicator = false
        }
    }
}
