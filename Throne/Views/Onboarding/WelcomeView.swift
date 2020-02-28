//
//  WelcomeView.swift
//  Throne
//
//  Created by Nicholas Josephson on 2020-02-01.
//  Copyright © 2020 Throne. All rights reserved.
//

import SwiftUI

struct WelcomeView: View {
    var loginController = LoginViewController()
    var myBlueColor = Color (
        red: 94.0,
        green: 162.0,
        blue: 231.0,
        opacity: 1.0
    )
    
    
    var myBlueColor2 = Color (
        red: 255.0,
        green: 255.0,
        blue: 255.0,
        opacity: 1.0
    )
    
    var body: some View {
        HStack {
            Spacer()
            VStack() {
                Spacer()
                    .frame(height: 100)
                Text("Welcome to Throne")
                    .font(.system(size: 60))
                    .foregroundColor(Color.white)
                    .multilineTextAlignment(.center)
                Spacer()
                    .frame(height: 150)
                Button(action: { self.loginController.startLogin() }) {
                    Text("Login").font(.title)
                }
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.red)
                    .cornerRadius(20)
                    .padding()
                Button(action: { self.loginController.startSignup() }) {
                    Text("Sign Up").font(.title)
                }
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.red)
                    .cornerRadius(20)
                LoginView(controller: loginController).frame(width: 0, height: 0, alignment: .bottom)
                Spacer()
            }
            Spacer()
        }
        .background(LinearGradient(gradient: Gradient(colors: [.red, .blue]), startPoint: .bottom, endPoint: .top).edgesIgnoringSafeArea(.all))
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
