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
    @ObservedObject var model = NearMe.shared

    var body: some View {
        TabView(selection: $currentTab) {
            NearMeView(nearMe: model)
                .tabItem {
                    VStack {
                        Image(systemName: "mappin.and.ellipse")
                        Text("Near Me")
                    }
                }
                .tag(0)
            MapView(nearMe: model)
                .tabItem {
                    VStack {
                        Image(systemName: "map")
                        Text("Map")
                    }
                }
                .tag(1)
            ProfileView(nearMe: model)
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
