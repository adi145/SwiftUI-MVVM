//
//  History.swift
//  SampleSwiftUIDemo
//
//  Created by Adinarayana Machavarapu on 1/7/2563 BE.
//  Copyright © 2563 Adinarayana Machavarapu. All rights reserved.
//

import SwiftUI
import Combine

struct History: View {
    
    @ObservedObject var historyViewModel = HistoryViewModel()

    var body: some View {
        ZStack{
           List {
               ForEach(historyViewModel.bookedMoviesList) { bookedMovies in
                       HStack {
                           HStack{
                               ImageViewContainer(imageUrl:  Constants.Apiurl.imageDownloadUrl + bookedMovies.movieID, imageWidth: 100, imageHeight: 100 ).clipShape(Circle())
                           }
                           Spacer().frame(width: 10, height: 0.0, alignment: .leading)
                        HStack {
                            VStack(alignment: .leading, spacing: 5.0){
                                Text(String(bookedMovies.movieName)).font(.title)
                                HStack(spacing: 5){
                                    Text("Director:").font(.headline)
                                    Text(bookedMovies.director)
                                }
                                Text(bookedMovies.initialReleaseDate).font(.headline).foregroundColor(Color.blue)
                            }
                        }
                           .padding(.leading, CGFloat(0.0))
                       }
               }.onDelete(perform: self.delete(at:))
           }
            ActivityIndicator(isAnimating: .constant(self.historyViewModel.showActivityIndicator), style: .large).frame(width: UIScreen.screenWidth/2, height: UIScreen.screenHeight/2, alignment: .center)
        }.onAppear(){
            self.historyViewModel.getBookedMoviesList()
        }
    }
    
    func delete(at offsets: IndexSet) {
        if let first = offsets.first {
            print(first)
            self.historyViewModel.bookedMoviesList.remove(at: first)
        }
    }
}

struct History_Previews: PreviewProvider {
    static var previews: some View {
        History(historyViewModel: HistoryViewModel())
    }
}
