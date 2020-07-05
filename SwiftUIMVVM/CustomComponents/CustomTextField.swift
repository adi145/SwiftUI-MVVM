//
//  CustomTextField.swift
//  SampleSwiftUIDemo
//
//  Created by Adinarayana Machavarapu on 26/6/2563 BE.
//  Copyright © 2563 Adinarayana Machavarapu. All rights reserved.
//

import SwiftUI

struct CustomTextField: View {
   
    @Binding var textfilevalue: String
    @State var placeholderText = ""

    var body: some View {
        TextField(placeholderText, text: $textfilevalue, onEditingChanged: { (status) in
            print(status)
        }, onCommit: {
            print("Retrun button tapped")
        }).modifier(CustomTextBorder())
    }
}
struct CustomPasswordTextField: View {
    @Binding var textfilevalue: String
    @State var placeholderText = ""

    var body: some View {
        SecureField(placeholderText, text: $textfilevalue)
        .modifier(CustomTextBorder())
    }
}

struct CustomTextBorder: ViewModifier {
    func body(content: Content) -> some View {
        return content
            .padding(.leading)
            .frame(width:UIScreen.main.bounds.width - 40, height: 40.0)
            .background(Color.white)
            .cornerRadius(10)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.gray, lineWidth: 1)
        )
    }
}




