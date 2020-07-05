//
//  CustomeButton.swift
//  SampleSwiftUIDemo
//
//  Created by Adinarayana Machavarapu on 29/6/2563 BE.
//  Copyright © 2563 Adinarayana Machavarapu. All rights reserved.
//

import SwiftUI

struct CustomeButton: View {
    var onAction: () -> Void
    @State var buttonName: String = ""
    var backGroundColor : Color
    var textColor : Color
    
    var body: some View {
        Button(action: self.onAction) {
            Text(buttonName).foregroundColor(textColor)
        }
        .frame(width: UIScreen.main.bounds.width - 40, height: 40)
        .background(backGroundColor)
        .cornerRadius(10)
        .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.gray, lineWidth: 1)
        )
    }
}
