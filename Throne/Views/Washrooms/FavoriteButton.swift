//
//  FavoriteButton.swift
//  Throne
//
//  Created by Nicholas Josephson on 2020-02-27.
//  Copyright © 2020 Throne. All rights reserved.
//

import SwiftUI

struct FavoriteButton: View {
    @ObservedObject var washroom: Washroom
    
    var body: some View {
        Button(
            action: {
                self.washroom.makeFavorite()
            },
            label: {
                HStack {
                    if self.washroom.isFavorite {
                        Image(systemName: "bookmark.fill")
                    } else {
                        Image(systemName: "bookmark")
                    }
                    Text("Favourite")
                }
            }
        )
    }
}

struct FavoriteButton_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteButton(washroom: Washroom())
    }
}
