//
//  SpinnerRowView.swift
//  Throne
//
//  Created by Nicholas Josephson on 2020-03-26.
//  Copyright © 2020 Throne. All rights reserved.
//

import SwiftUI

struct SpinnerRowView: View {
    var body: some View {
        HStack {
            Spacer()
            SpinnerView()
            Spacer()
        }
    }
}

struct SpinnerRowView_Previews: PreviewProvider {
    static var previews: some View {
        SpinnerRowView()
    }
}
