//
//  ProfileView.swift
//  Throne
//
//  Created by Nicholas Josephson on 2020-01-30.
//  Copyright © 2020 Throne. All rights reserved.
//

import SwiftUI

struct ProfileView: View {
    @ObservedObject var nearMe: NearMe
    @State private var currentListType = ProfileListView.ProfileListType.favorites
    
    var body: some View {
        NavigationView {
            ProfileListView(nearMe: self.nearMe, currentListType: self.$currentListType)
                .navigationBarTitle("", displayMode: .inline)
                .navigationBarItems(
                    leading: HStack {
                        if self.currentListType == .favorites {
                            EditButton()
                        }
                    },
                    trailing: NavigationLink(destination: SettingsView()) {
                        HStack {
                            Image(systemName: "gear")
                                .accessibility(hidden: true)
                            Text("Settings")
                        }
                    }
                )
            
            if currentListType == .favorites {
                Text("No Favorite Selected")
                    .foregroundColor(.secondary)
            } else {
                Text("No Review Selected")
                    .foregroundColor(.secondary)
            }
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(nearMe: NearMe.shared)
    }
}
