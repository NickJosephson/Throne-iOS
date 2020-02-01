//
//  LoginVIew.swift
//  Throne
//
//  Created by Nicholas Josephson on 2020-01-31.
//  Copyright © 2020 Throne. All rights reserved.
//

import SwiftUI

struct LoginView: UIViewRepresentable {
    var controller: UIViewController
    
    func makeUIView(context: Context) -> UIView {
        return controller.view
    }

    func updateUIView(_ uiView: UIView, context: Context) {
    }
}

struct LoginVIew_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(controller: LoginUIViewController())
    }
}
