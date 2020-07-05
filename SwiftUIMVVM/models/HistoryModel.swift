//
//  HistoryModel.swift
//  SampleSwiftUIDemo
//
//  Created by Adinarayana Machavarapu on 2/7/2563 BE.
//  Copyright © 2563 Adinarayana Machavarapu. All rights reserved.
//

import Foundation

struct HistoryModel {
    
    struct BookedMoviesList: Codable {
        let message: String
        let data: [BookedMovie]
    }

    // MARK: - BookedMovie
    struct BookedMovie: Codable,Identifiable {
        let id: Int
        let userID, movieID: String
        let fileName, fileType: String?
        let movieName, datumDescription, company, director: String
        let producer: String
        let initialReleaseDate, actors: String

        enum CodingKeys: String, CodingKey {
            case id
            case userID = "userId"
            case movieID = "movieId"
            case fileName, fileType, movieName
            case datumDescription = "description"
            case company, director, producer, initialReleaseDate, actors
        }
    }
}
