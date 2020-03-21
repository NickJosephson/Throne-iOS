//
//  MainTabView.swift
//  Throne
//
//  Created by Nicholas Josephson on 2020-02-27.
//  Copyright © 2020 Throne. All rights reserved.
//

import SwiftUI

struct MainTabView: View {
    @State private var currentTab = 0
    
    var body: some View {
        TabView(selection: $currentTab) {
            NearMeView()
                .tabItem {
                    VStack {
                        Image(systemName: "mappin.and.ellipse")
                        Text("Near Me")
                    }
                }
                .tag(0)
            MapView()
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

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}
