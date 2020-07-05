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
     
        apimanager.getMethod(url: Constants.Apiurl.moviesListUrl + "/" + String(KeyChain.getUserId()), success: { (jsonData) in
                do {
                    let results = try JSONDecoder().decode(MoviesModels.MoviesList.self, from: jsonData)
                 //   print("results",results.data)
                    DispatchQueue.main.async {
                        self.moviesList.removeAll()
                        self.moviesList = results.data
                        self.showActivityIndicator = false
                    }
                } catch {
                    print(error)
                    self.showActivityIndicator = false
                }
        }) { (error) in
            print("moviles list",error ?? "")
            self.showActivityIndicator = false
        }
    }
}
