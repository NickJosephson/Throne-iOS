//
//  ContentView.swift
//  Throne
//
//  Created by Nicholas Josephson on 2020-01-30.
//  Copyright © 2020 Throne. All rights reserved.
//

import SwiftUI
import Combine

struct ContentView: View {
    @ObservedObject private var loginManager = LoginManager.shared
    @ObservedObject private var loginObserver = LoginObserver()
    
    var body: some View {
        MainTabView()
            .disabled(!loginManager.isLoggedIn)
            .opacity(!loginManager.isLoggedIn ? 0.5 : 1.0)
            .sheet(
                isPresented: $loginObserver.showWelcomeScreen,
                content: { WelcomeView() }
            )
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

final class LoginObserver: ObservableObject {
    private var loginManager = LoginManager.shared
    private var loginStateSubscription: AnyCancellable!
    
    /// Always reflects the opposite of isLoggedIn, even if set other wise.
    ///
    /// This is a workaround for the fact that SwiftUI sheets do not currently allow restricting the user from closing them.
    @Published var showWelcomeScreen: Bool {
        didSet {
            if showWelcomeScreen == loginManager.isLoggedIn {
                showWelcomeScreen = !loginManager.isLoggedIn
            }
        }
    }
    
    init() {
        showWelcomeScreen = !loginManager.isLoggedIn
        
        loginStateSubscription = loginManager.$isLoggedIn
            .receive(on: RunLoop.main)
            .map { !$0 }
            .assign(to: \.showWelcomeScreen, on: self)
    }
}
