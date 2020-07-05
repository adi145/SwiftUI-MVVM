//
//  UserProfile.swift
//  SampleSwiftUIDemo
//
//  Created by Adinarayana Machavarapu on 1/7/2563 BE.
//  Copyright © 2563 Adinarayana Machavarapu. All rights reserved.
//

import SwiftUI

struct UserProfile: View {

    @ObservedObject var userViewModel: LoginViewModel

    var body: some View {
        ZStack {
            List{
                Spacer().frame(width: 0, height: 40, alignment: .center)
                Section() {
                    HStack{
                        Spacer()
                    CircleImageView(width: 150, heigh: 150, imageName: "cimblogo")
                        Spacer()
                    }
                }
                Spacer().frame(width: 0, height: 20, alignment: .topLeading)

                ForEach(0..<self.userViewModel.userProfileData.count, id: \.self) { index in
                    VStack{
                        CustomTextField(textfilevalue: self.$userViewModel.userProfileData[index], placeholderText: self.userViewModel.userProfilePlaceHolderList[index])
                    }
                }
                Section() {
                    CustomeButton(onAction: {
                        print("Book Button Tapped")
                        self.userViewModel.profileUpdate()
                    }, buttonName: "Update", backGroundColor: Color(.systemTeal), textColor: Color.white)
                }
                .padding(.vertical, 10.0)
            }.modifier(AdaptsToSoftwareKeyboard())
            ActivityIndicator(isAnimating: .constant(self.userViewModel.showActivityIndicator), style: .large).frame(width: UIScreen.screenWidth/2, height: UIScreen.screenHeight/2, alignment: .center)
            }
        .onAppear(){
            UITableView.appearance().separatorStyle = .none
            self.userViewModel.getUserProfileData()
        }.onDisappear(){
            print(self.userViewModel.userProfileData)
        }
    }
}


struct UserProfile_Previews: PreviewProvider {
    static var previews: some View {
        UserProfile(userViewModel: LoginViewModel())
    }
}

// This is taken from the Release Notes, with a typo correction, marked below
struct IndexedCollection<Base: RandomAccessCollection>: RandomAccessCollection {
    typealias Index = Base.Index
    typealias Element = (index: Index, element: Base.Element)

    let base: Base

    var startIndex: Index { base.startIndex }

   // corrected typo: base.endIndex, instead of base.startIndex
    var endIndex: Index { base.endIndex }

    func index(after i: Index) -> Index {
        base.index(after: i)
    }

    func index(before i: Index) -> Index {
        base.index(before: i)
    }

    func index(_ i: Index, offsetBy distance: Int) -> Index {
        base.index(i, offsetBy: distance)
    }

    subscript(position: Index) -> Element {
        (index: position, element: base[position])
    }
}

extension RandomAccessCollection {
    func indexed() -> IndexedCollection<Self> {
        IndexedCollection(base: self)
    }
}
