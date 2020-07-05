//
//  CircleImageView.swift
//  SampleSwiftUIDemo
//
//  Created by Adinarayana Machavarapu on 26/6/2563 BE.
//  Copyright © 2563 Adinarayana Machavarapu. All rights reserved.
//

import SwiftUI

struct CircleImageView: View {
    @State var width: CGFloat = 150.0
    @State var heigh: CGFloat = 150.0
    @State var imageName = "cimblogo"
    var body: some View {
        Image(imageName)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: width, height: heigh)
            .background(Color.orange).cornerRadius(10.0)
            .clipShape(Circle())
            .overlay(
                Circle().stroke(Color.white, lineWidth: 2)
        )
    }
}
