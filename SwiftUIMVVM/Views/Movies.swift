//
//  Movies.swift
//  SampleSwiftUIDemo
//
//  Created by Adinarayana Machavarapu on 1/7/2563 BE.
//  Copyright © 2563 Adinarayana Machavarapu. All rights reserved.
//

import SwiftUI
import Combine

struct Movies: View {
  
    @ObservedObject var viewModel = MoviesViewModel()
    
    var body: some View {
        ZStack{
            List {
                ForEach(viewModel.moviesList) { movie in
                    NavigationLink(destination: MovieDetails(movieDetails: movie) ) {
                        HStack {
                            HStack{
                                ImageViewContainer(imageUrl:  Constants.Apiurl.imageDownloadUrl + movie.id, imageWidth: 100, imageHeight: 100 ).clipShape(Circle())
                            }
                            Spacer().frame(width: 10, height: 0.0, alignment: .leading)
                            HStack {
                                VStack(alignment: .leading, spacing: 5.0){
                                    Text(String(movie.movieName)).font(.title)
                                    HStack(spacing: 5){
                                        Text("Director:").font(.headline)
                                        Text(movie.director)
                                    }
                                    Text(movie.initialReleaseDate).font(.headline).foregroundColor(Color.blue)
                                }
                                
                            }
                            .padding(.leading, 0.0)
                        }
                    }
                    Divider().background(Color.green)
                }.onDelete(perform: self.delete(at:))
            }

            ActivityIndicator(isAnimating: .constant(self.viewModel.showActivityIndicator), style: .large).frame(width: UIScreen.screenWidth/2, height: UIScreen.screenHeight/2, alignment: .center)
        }.onAppear(){
            UITableView.appearance().separatorStyle = .none
            self.viewModel.getMoviesList()
        }
    }
    func delete(at offsets: IndexSet) {
        if let first = offsets.first {
            print(first)
            self.viewModel.moviesList.remove(at: first)
        }
    }
}

struct Movies_Previews: PreviewProvider {
    static var previews: some View {
        Movies()
    }
}

