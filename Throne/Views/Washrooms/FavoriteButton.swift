//
//  FavoriteButton.swift
//  Throne
//
//  Created by Nicholas Josephson on 2020-02-27.
//  Copyright © 2020 Throne. All rights reserved.
//

import SwiftUI

struct FavoriteButton: View {
    @Binding var isFavorite: Bool
    
    var body: some View {
        Button(
            action: {
                self.isFavorite.toggle()
            },
            label: {
                HStack {
                    if self.isFavorite {
                        Image(systemName: "bookmark.fill")
                    } else {
                        Image(systemName: "bookmark")
                    }
                    Text("Favourite")
                }
            }
        )
            .disabled(true)
            .opacity(0.5)
    }
}

struct FavoriteButton_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteButton(isFavorite: .constant(true))
    }
}
