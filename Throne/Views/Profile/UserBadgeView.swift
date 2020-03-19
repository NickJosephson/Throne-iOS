//
//  UserBadgeView.swift
//  Throne
//
//  Created by Nicholas Josephson on 2020-03-19.
//  Copyright © 2020 Throne. All rights reserved.
//

import SwiftUI

struct UserBadgeView: View {
    @ObservedObject private var loginManager = LoginManager.shared
    @Environment(\.verticalSizeClass) var verticalSizeClass

    var body: some View {
        VStack() {
            if verticalSizeClass != .compact {
                Image(systemName: "person.circle")
                   .resizable()
                   .scaledToFit()
                   .frame(width: 100, height: 100)
                   .cornerRadius(90)
                   .accessibility(hidden: true)
            }
            Text("\(loginManager.currentUser?.username ?? " ")")
                .font(.largeTitle)
                .multilineTextAlignment(.center)
                .accessibility(label: Text("username \(loginManager.currentUser?.username ?? "")"))
                .accessibility(hidden: loginManager.currentUser?.username == nil)
        }
        .onAppear {
            self.loginManager.requestUserFetch.send()
        }
    }
}

struct UserBadgeView_Previews: PreviewProvider {
    static var previews: some View {
        UserBadgeView()
    }
}
