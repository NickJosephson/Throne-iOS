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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
