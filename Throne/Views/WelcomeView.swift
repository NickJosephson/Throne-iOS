//
//  WelcomeView.swift
//  Throne
//
//  Created by Nicholas Josephson on 2020-02-01.
//  Copyright © 2020 Throne. All rights reserved.
//

import SwiftUI

struct WelcomeView: View {
    var loginController = LoginUIViewController()
    
    var body: some View {
        VStack() {
            Spacer()
            VStack(spacing: 20) {
                Text("🧻")
                    .font(.system(size: 100))
                Text("Welcome to Throne!")
                    .font(.largeTitle)
            }
            Spacer()
            Button(action: { self.loginController.session.start() }) {
                Text("Login").font(.title)
            }
                .padding()
                .foregroundColor(.white)
                .background(Color.red)
                .cornerRadius(20)
                .padding()
            Button(action: { LoginManager.sharedInstance.login() }) {
                Text("Sign Up").font(.title)
            }
                .padding()
                .foregroundColor(.white)
                .background(Color.red)
                .cornerRadius(20)
                .padding()
            LoginView(controller: loginController).frame(width: 0, height: 0, alignment: .bottom)
        }
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
