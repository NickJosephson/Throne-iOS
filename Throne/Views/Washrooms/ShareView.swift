//
//  ShareView.swift
//  Throne
//
//  Created by Nicholas Josephson on 2020-03-09.
//  Copyright © 2020 Throne. All rights reserved.
//

import SwiftUI

struct ShareView: UIViewControllerRepresentable {
    let activityItems: [Any]
    let callback: () -> Void

    func makeUIViewController(context: Context) -> UIActivityViewController {
        let controller = UIActivityViewController(
            activityItems: activityItems,
            applicationActivities: nil)
        controller.completionWithItemsHandler = { activityType, completed, returnedItems, error in
            self.callback()
        }
        return controller
    }
      
    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {

    }
}

struct ShareView_Previews: PreviewProvider {
    static var previews: some View {
        ShareView(activityItems: ["Test"], callback: {})
    }
}
