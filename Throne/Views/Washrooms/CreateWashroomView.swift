//
//  CreateWashroomView.swift
//  Throne
//
//  Created by Nicholas Josephson on 2020-02-27.
//  Copyright © 2020 Throne. All rights reserved.
//

import SwiftUI

struct CreateWashroomView: View {
    @Binding var show: Bool
    @State private var floor = 1
    @State private var gender = Gender.all
    @State private var title = ""
    @State private var amenities: [Amenity] = []

    var body: some View {
        NavigationView {
            Form {
                Section {
                    GenderSelectionView(gender: self.$gender)
                    Stepper("Floor \(floor)", value: $floor)
                    TextField("Additional Title", text: $title)
                }
                Section(header: Text("Amenities")) {
                    AmenitiesSelectionView(amenities: self.$amenities)
                }
            }
            .navigationBarTitle("New Washroom", displayMode: .inline)
            .navigationBarItems(
                leading: Button(action: { self.show = false }, label: { Text("Cancel") }),
                trailing: Button(action: { self.show = false }, label: { Text("Add") })
            )
        }
    }
}

struct CreateWashroomView_Previews: PreviewProvider {
    static var previews: some View {
        CreateWashroomView(show: .constant(true))
    }
}
