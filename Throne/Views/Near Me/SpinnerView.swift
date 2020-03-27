//
//  SpinnerView.swift
//  Throne
//
//  Created by Nicholas Josephson on 2020-03-26.
//  Copyright © 2020 Throne. All rights reserved.
//

import SwiftUI

struct SpinnerView: UIViewRepresentable {
    
    func makeUIView(context: Context) -> UIView {
        let spinner = UIActivityIndicatorView()
        spinner.startAnimating()
        
        return spinner
    }

    func updateUIView(_ uiView: UIView, context: Context) {
    }
}

struct SpinnerView_Previews: PreviewProvider {
    static var previews: some View {
        SpinnerView()
    }
}
