//
//  ProfileView.swift
//  Throne
//
//  Created by Nicholas Josephson on 2020-01-30.
//  Copyright © 2020 Throne. All rights reserved.
//

import SwiftUI

struct ProfileView: View {
    @Environment(\.verticalSizeClass) var horizontalSizeClass
    @ObservedObject private var loginManager = LoginManager.shared
    
    var body: some View {
        NavigationView {
            VStack() {
                if horizontalSizeClass != .compact {
                    VStack {
                        AvatarView()
                        NameView(user: loginManager.currentUser)
                    }
                    .padding(30)
                } else {
                    HStack {
                        AvatarView()
                        NameView(user: loginManager.currentUser)
                    }
                    .padding(10)
                }
            }
            .navigationBarTitle("", displayMode: .inline)
            .navigationBarItems(
                trailing: NavigationLink(destination: SettingsView()) { Image(systemName: "gear") }
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
    }
}

struct NameView: View {
    var user: User?
    
    var body: some View {
        Text("\(user?.username ?? "")")
        .font(.largeTitle)
        .multilineTextAlignment(.center)
    }
}


struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
