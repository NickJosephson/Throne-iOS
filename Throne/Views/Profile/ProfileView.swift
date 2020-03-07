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
    @ObservedObject private var loginManager = LoginManager.shared
    @Environment(\.verticalSizeClass) var verticalSizeClass
    @State var currentListType = ProfileListView.ProfileListType.favorites
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                if verticalSizeClass != .compact {
                    AvatarView()
                        .padding(.top)
                }
                NameView(user: loginManager.currentUser)
                ProfileListView(nearMe: self.nearMe, currentListType: self.$currentListType)
            }
            .onAppear {
                self.loginManager.requestUserFetch.send()
            }
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
//        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct AvatarView: View {
    var body: some View {
        Image(systemName: "person.circle")
        .resizable()
        .scaledToFit()
        .frame(width: 100, height: 100)
        .cornerRadius(90)
        .accessibility(hidden: true)
    }
}

struct NameView: View {
    var user: User?
    
    var body: some View {
        Text("\(user?.username ?? "")")
        .font(.largeTitle)
        .multilineTextAlignment(.center)
        .accessibility(label: Text("username \(user?.username ?? "")"))
        .accessibility(hidden: user?.username == nil)
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(nearMe: NearMe.shared)
    }
}
