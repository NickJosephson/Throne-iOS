//
//  WelcomeView.swift
//  Throne
//
//  Created by Nicholas Josephson on 2020-02-01.
//  Copyright © 2020 Throne. All rights reserved.
//

import SwiftUI

extension Color {
    static func backgroundGradientColor(for colorScheme: ColorScheme) -> LinearGradient {
        if colorScheme == .dark {
            return LinearGradient(gradient: Gradient(colors: [
                        Color(red: 0.0, green: 0.1529411765, blue: 0.3019607843, opacity: 1.0),
                        Color(red: 0, green: 0.2941176471, blue: 0.4235294118, opacity: 1.0)]
                    ), startPoint: .bottom, endPoint: .top)
        } else {
            return LinearGradient(gradient: Gradient(colors: [
                        Color(red: 0.3647058824, green: 0.6392156863, blue: 0.9058823529, opacity: 1.0),
                        Color(red: 0.4862745098, green: 0.8392156863, blue: 1, opacity: 1.0)]
                    ), startPoint: .top, endPoint: .bottom)
        }
    }
}

struct WelcomeView: View {
    @Environment (\.colorScheme) var colorScheme:ColorScheme
    
    var loginController = LoginViewController()
    
    var body: some View {
        HStack {
            Spacer()
            VStack() {
                Spacer()
                    .frame(height: 175)
                Text("Welcome to Throne")
                    .font(.system(size: 60))
                    .foregroundColor(Color.white)
                    .multilineTextAlignment(.center)
                Spacer()
                    .frame(height: 150)
                Button(action: { self.loginController.startLogin() }) {
                    Text("Login")
                        .font(.system(size: 25))
                        .frame(width: 200.0, height: 20.0)
                }
                    .padding()
                    .foregroundColor(Color.white)
                    .background(Color(red: 0.1019607843, green: 0.5647058824, blue: 1, opacity: 1.0))
                    .cornerRadius(30)
                    .padding(5)
                Button(action: { self.loginController.startSignup() }) {
                    Text("Sign Up")
                        .font(.system(size: 25))
                        .frame(width: 200.0, height: 20.0)
                }
                    .padding()
                    .foregroundColor(Color.black)
                    .background(Color.white)
                    .cornerRadius(30)
                    .padding(5)
                LoginView(controller: loginController).frame(width: 0, height: 0, alignment: .bottom)
                Spacer()
            }
            Spacer()
        }
        .background((Color.backgroundGradientColor(for: colorScheme))).edgesIgnoringSafeArea(.all)
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
