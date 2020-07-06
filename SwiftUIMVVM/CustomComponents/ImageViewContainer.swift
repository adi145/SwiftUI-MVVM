//
//  ImageViewContainer.swift
//  SampleSwiftUIDemo
//
//  Created by Adinarayana Machavarapu on 1/7/2563 BE.
//  Copyright © 2563 Adinarayana Machavarapu. All rights reserved.
//

import SwiftUI

struct ImageViewContainer: View {
    @ObservedObject var remoteImageURL: RemoteImageURL
    var imageWidth : CGFloat = 100
    var imageHeight : CGFloat = 100
    
    init(imageUrl: String, imageWidth: CGFloat, imageHeight: CGFloat) {
        remoteImageURL = RemoteImageURL(imageURL: imageUrl)
        self.imageWidth = imageWidth
        self.imageHeight = imageHeight
    }

    var body: some View {
        Image(uiImage: UIImage(data: remoteImageURL.data) ?? UIImage())
            .resizable()
          //  .clipShape(Circle())
          //  .overlay(Circle().stroke(Color.black, lineWidth: 3.0))
            .frame(width: imageWidth, height: imageHeight)
    }
}

class RemoteImageURL: ObservableObject {
    @Published var data = Data()
    init(imageURL: String) {
        let imageUrl1 = Constants.Apiurl.baseUrl + imageURL
        guard let url = URL(string: imageUrl1) else { return }

        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }
            DispatchQueue.main.async { self.data = data }

            }.resume()
    }
}
