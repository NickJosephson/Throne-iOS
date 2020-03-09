//
//  GenderSelectionView.swift
//  Throne
//
//  Created by Nicholas Josephson on 2020-02-27.
//  Copyright © 2020 Throne. All rights reserved.
//

import SwiftUI

struct GenderSelectionView: View {
    @Binding var gender: Gender

    var body: some View {
        Picker(selection: $gender, label: Text("Gender")) {
            ForEach(Gender.allCases, id: \.self) { gender in
                Text(gender.description).tag(gender)
            }
        }
        .pickerStyle(SegmentedPickerStyle())
    }
}

struct GenderSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        GenderSelectionView(gender: .constant(.all))
    }
}
