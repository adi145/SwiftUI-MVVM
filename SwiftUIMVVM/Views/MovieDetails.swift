//
//  MovieDetails.swift
//  SampleSwiftUIDemo
//
//  Created by Adinarayana Machavarapu on 1/7/2563 BE.
//  Copyright © 2563 Adinarayana Machavarapu. All rights reserved.
//

import SwiftUI

struct MovieDetails: View {
    var movieDetails: MoviesModels.Movie
    @ObservedObject var viewModel = MovieDetailsViewModel()
    @State var screenHeight :CGFloat = 0
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>

    var body: some View {
        ZStack{
            ScrollView{
                Spacer().frame(width: 0, height: 0.0, alignment: .top)
                VStack(alignment: .leading, spacing: 10){
                    ImageViewContainer(imageUrl: Constants.Apiurl.imageDownloadUrl + movieDetails.id, imageWidth: UIScreen.main.bounds.width-40, imageHeight: 200)
                    Text(movieDetails.movieName).font(.title).multilineTextAlignment(.leading)
                    HStack(spacing:10){
                        Text("Director:").font(.headline)
                        Text(movieDetails.director)
                            .multilineTextAlignment(.leading)
                    }
                    HStack(spacing:10){
                        Text("Producers:").font(.headline)
                        Text(movieDetails.producer)
                            .multilineTextAlignment(.leading)
                    }
                    HStack(spacing:10){
                        Text("Production company:").font(.headline).multilineTextAlignment(.leading)
                        Text(movieDetails.company)
                            .multilineTextAlignment(.leading)
                    }
                    HStack(spacing:10){
                        Text("Actors:").font(.headline).multilineTextAlignment(.leading)
                        Text(movieDetails.actors)
                            .multilineTextAlignment(.leading).foregroundColor(Color.blue)
                    }
                    Text(movieDetails.initialReleaseDate).foregroundColor(Color.blue)
                    Text(movieDetails.movieDescription)
                        .multilineTextAlignment(.leading)
                }
            }.padding(.horizontal)
                .frame(height: UIScreen.screenHeight-88-44-50)
            VStack(){
                Spacer()
                CustomeButton(onAction: {
                    print("Book Button Tapped")
                    self.viewModel.bookMovie(movieId: self.movieDetails.id)
                }, buttonName: "Book Ticket", backGroundColor: Color(.systemTeal), textColor: Color.white)
            }
        }.alert(isPresented: self.$viewModel.bookedTicketConfirm, content: { self.bookTicketConfirmationAlert })
        .onAppear(){
            
        }
    }
    var bookTicketConfirmationAlert: Alert {
        Alert(title: Text(""), message: Text("Ticket booked successfully"),dismissButton:.default(Text("Ok"), action: {
            self.mode.wrappedValue.dismiss()
        }))
    }
    
}

struct MovieDetails_Previews: PreviewProvider {
    static var previews: some View {
        MovieDetails(movieDetails: MoviesModels.Movie(id: "", fileName: "", fileType: "", movieName: "", movieDescription: "", company: "", director: "", producer: "",initialReleaseDate: "",actors: ""))
    }
}

extension UIScreen{
   static let screenWidth = UIScreen.main.bounds.size.width
   static let screenHeight = UIScreen.main.bounds.size.height
   static let screenSize = UIScreen.main.bounds.size
}
