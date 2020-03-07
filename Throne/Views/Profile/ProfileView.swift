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

    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                if verticalSizeClass != .compact {
                    AvatarView()
                }
                NameView(user: loginManager.currentUser)
                FavoritesListView(nearMe: self.nearMe)
            }
            .padding(.top)
            .navigationBarTitle("", displayMode: .inline)
            .navigationBarItems(
                trailing: NavigationLink(destination: SettingsView()) {
                    Image(systemName: "gear")
                        .accessibility(label: Text("Settings"))
                }
            )
            .onAppear {
                self.loginManager.requestUserFetch.send()
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
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
