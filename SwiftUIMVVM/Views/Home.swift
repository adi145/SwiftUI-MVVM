//
//  Home.swift
//  SampleSwiftUIDemo
//
//  Created by Adinarayana Machavarapu on 29/6/2563 BE.
//  Copyright © 2563 Adinarayana Machavarapu. All rights reserved.
//

import SwiftUI

struct Home: View {
  
    @EnvironmentObject var settings : UserSettings
    @State var navigationTitle = "Movies"
    @State private var selectedTab = 0
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @State var tabIndex = -1
    var body: some View {
        
        let selection = Binding<Int>(
            get: { self.selectedTab },
            set: { self.selectedTab = $0
                print("Pressed tab: \($0)")
                self.tabIndex = $0
                if $0 == 1 {
                    self.navigationTitle = "Movies"
                } else if $0 == 2 {
                    self.navigationTitle = "History"
                } else if $0 == 3 {
                    self.tabIndex = 3
                    self.navigationTitle = "Profile"
                }
        })
        return TabView(selection: selection) {
            Movies()
                .tabItem {
                    Image(systemName: "house").imageScale(.large).foregroundColor(Color.blue)
                    Text("Home")
            }.tag(1)
            History(historyViewModel: HistoryViewModel())
                .tabItem {
                    Image(systemName: "clock").imageScale(.large).foregroundColor(Color.blue)
                    Text("History")
            }.tag(2)
            UserProfile(userViewModel: LoginViewModel())
                .tabItem {
                    Image(systemName: "person.crop.circle").imageScale(.large).foregroundColor(Color.blue)
                    Text("Profile")
            }.tag(3)
        }
        .navigationBarTitle(Text(self.navigationTitle), displayMode: .inline)
        .navigationBarHidden(false)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(trailing: self.tabIndex == 3 ?
            AnyView(self.navigationBarButton) : AnyView(EmptyView()))
    }
    
    var navigationBarButton: some View {
     Button(action: {
        UserDefaults.standard.set("", forKey: "login")
        self.settings.isNavigateToHomeScreen = false
      }) {
          Text("Logout").foregroundColor(.red)
      }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
