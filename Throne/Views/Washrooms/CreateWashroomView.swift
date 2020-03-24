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
    @ObservedObject private var settings = PersistentSettings.shared
    @State private var floor = 1
    @State private var stallsCount = 1
    @State private var urinalsCount = 0
    @State private var gender = Gender.all
    @State private var additionalTitle = ""
    @State private var amenities: [Amenity] = []

    var body: some View {
        NavigationView {
            Form {
                Section {
                    Text("\(building.title)")
                    GenderSelectionView(gender: self.$gender)
                    Stepper(value: $floor, in: 0...10) {
                        HStack {
                            Text("Floor")
                            Text("\(floor)").accessibility(hidden: true)
                        }
                    }
                        .accessibility(value: Text("\(floor)"))
                    Stepper(value: $stallsCount, in: 1...50) {
                       HStack {
                           Text("Stalls")
                           Text("\(stallsCount)").accessibility(hidden: true)
                       }
                   }
                       .accessibility(value: Text("\(stallsCount)"))
                    Stepper(value: $urinalsCount, in: 0...50) {
                       HStack {
                           Text("Urinals")
                           Text("\(urinalsCount)").accessibility(hidden: true)
                       }
                   }
                       .accessibility(value: Text("\(urinalsCount)"))
                    TextField("Additional Description", text: $additionalTitle)
                }
                Section(header: Text("Amenities")) {
                    AmenitiesSelectionView(amenities: self.$amenities)
                }
            }
            .navigationBarTitle("New \(settings.preferredTerm.capitalized)", displayMode: .inline)
            .navigationBarItems(
                leading: Button(action: { self.show = false }, label: { Text("Cancel") }),
                trailing: Button(action: {
                    let newWashroom = Washroom()
                    newWashroom.amenities = self.amenities
                    newWashroom.floor = self.floor
                    newWashroom.gender = self.gender
                    newWashroom.stallsCount = self.stallsCount
                    newWashroom.urinalsCount = self.urinalsCount
                    newWashroom.additionalTitle = self.additionalTitle
                    newWashroom.location = self.building.location
                    newWashroom.buildingID = self.building.id
                    self.building.postWashroom(washroom: newWashroom)
                    self.show = false
                }, label: { Text("Add") })
            )
        }
        .frame(minWidth: 350, minHeight: 600)
    }
}

struct CreateWashroomView_Previews: PreviewProvider {
    static var previews: some View {
        CreateWashroomView(show: .constant(true), building: Building())
    }
}
