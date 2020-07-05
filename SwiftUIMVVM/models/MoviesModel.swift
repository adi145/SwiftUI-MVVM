//
//  MoviesModel.swift
//  SampleSwiftUIDemo
//
//  Created by Adinarayana Machavarapu on 1/7/2563 BE.
//  Copyright © 2563 Adinarayana Machavarapu. All rights reserved.
//

import Foundation

struct MoviesModels {
    
    struct MoviesList: Codable {
        let message: String
        let data: [Movie]
    }
    
    struct Movie: Codable,Identifiable {
        let id, fileName, fileType, movieName: String
        let movieDescription, company, director, producer : String
        let initialReleaseDate, actors: String

        enum CodingKeys: String, CodingKey {
            case id, fileName, fileType, movieName
            case movieDescription = "description"
            case company, director, producer, initialReleaseDate, actors
        }
    }
    
    struct BookMovie {
        let id:Int
        let movie_id: String
    }
}
