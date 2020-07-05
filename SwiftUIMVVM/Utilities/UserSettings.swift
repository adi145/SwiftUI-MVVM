//
//  UserSettings.swift
//  SampleSwiftUIDemo
//
//  Created by Adinarayana Machavarapu on 2/7/2563 BE.
//  Copyright © 2563 Adinarayana Machavarapu. All rights reserved.
//

import Foundation

class UserSettings: ObservableObject {
    @Published var ishideNavigationBar : Bool = false
    @Published var isNavigateToSignupScreen: Bool = false
    @Published var isNavigateToHomeScreen: Bool = true
    @Published var isNavigateMovieDetailsScreen: Bool = false
    @Published var showActivityIndicator:Bool = false
}

