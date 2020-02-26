//
//  ContentView.swift
//  Throne
//
//  Created by Nicholas Josephson on 2020-01-30.
//  Copyright © 2020 Throne. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject private var loginManager = LoginManager.shared
    
    var body: some View {
        MainTabView()
            .disabled(!loginManager.isLoggedIn)
            .opacity(!loginManager.isLoggedIn ? 0.5 : 1.0)
            .sheet(isPresented: $loginManager.showWelcomeScreen) {
                WelcomeView()
            }
    }
}

struct MainTabView: View {
    @State private var selection = 0
    
    var body: some View {
        TabView(selection: $selection) {
            NearMeView()
                .tabItem {
                    VStack {
                        Image(systemName: "mappin.and.ellipse")
                        Text("Near Me")
                    }
                }
                .tag(0)
            MapView(startLocation: nil)
                .tabItem {
                    VStack {
                        Image(systemName: "map")
                        Text("Map")
                    }
                }
                .tag(1)
            ProfileView()
                .tabItem {
                    VStack {
                        Image(systemName: "person.circle")
                        Text("Me")
                    }
                }
                .tag(2)
        }
        .edgesIgnoringSafeArea(.top)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
