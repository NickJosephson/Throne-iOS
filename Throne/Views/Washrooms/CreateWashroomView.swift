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
    @ObservedObject var building: Building
    @State private var floor = 1
    @State private var gender = Gender.all
    @State private var title = ""
    @State private var amenities: [Amenity] = []

    var body: some View {
        NavigationView {
            Form {
                Section {
                    GenderSelectionView(gender: self.$gender)
                    Stepper(value: $floor, in: 0...10) {
                        HStack {
                            Text("Floor")
                            Text("\(floor)").accessibility(hidden: true)
                        }
                    }
                        .accessibility(value: Text("\(floor)"))
                    TextField("Additional Title", text: $title)
                }
                Section(header: Text("Amenities")) {
                    AmenitiesSelectionView(amenities: self.$amenities)
                }
            }
            .navigationBarTitle("New Washroom", displayMode: .inline)
            .navigationBarItems(
                leading: Button(action: { self.show = false }, label: { Text("Cancel") }),
                trailing: Button(action: {
                    let newWashroom = Washroom()
                    newWashroom.amenities = self.amenities
                    newWashroom.floor = self.floor
                    newWashroom.gender = self.gender
                    newWashroom.comment = self.title
                    newWashroom.location = self.building.location
                    newWashroom.buildingID = self.building.id
                    self.building.postWashroom(washroom: newWashroom)
                    self.show = false
                }, label: { Text("Add") })
            )
        }
    }
}

struct CreateWashroomView_Previews: PreviewProvider {
    static var previews: some View {
        CreateWashroomView(show: .constant(true), building: Building())
    }
}
