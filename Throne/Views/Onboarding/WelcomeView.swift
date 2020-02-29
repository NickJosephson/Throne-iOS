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
                    .frame(height: 100)
                Button(action: { self.loginController.startLogin() }) {
                    Text("Login")
                        .font(.system(size: 25))
                        .frame(width: 200.0, height: 20.0)
                }
                    .padding()
                    .foregroundColor(.white)
                    .background(Color(red: 0.1019607843, green: 0.5647058824, blue: 1, opacity: 1.0))
                    .cornerRadius(30)
                    .padding(5)
                Button(action: { self.loginController.startSignup() }) {
                    Text("Sign Up")
                        .font(.system(size: 25))
                        .frame(width: 200.0, height: 20.0)
                }
                    .padding()
                    .foregroundColor(.black)
                    .background(Color.white)
                    .cornerRadius(30)
                    .padding(5)
                LoginView(controller: loginController).frame(width: 0, height: 0, alignment: .bottom)
                Spacer()
            }
            Spacer()
        }
        .background(LinearGradient(gradient: Gradient(colors: [
            Color(red: 0.3647058824, green: 0.6392156863, blue: 0.9058823529, opacity: 1.0),
            Color(red: 0.4862745098, green: 0.8392156863, blue: 1, opacity: 1.0)]
        ), startPoint: .bottom, endPoint: .top).edgesIgnoringSafeArea(.all))
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
