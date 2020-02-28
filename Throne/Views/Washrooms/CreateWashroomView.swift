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
    @State private var gender = Washroom.Gender.all
    @State private var title = ""
    @State private var amenities: [Washroom.Amenity] = []

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
                leading: Button(action: {self.show = false}, label: { Text("Cancel") }),
                trailing: Button(action: {self.show = false}, label: { Text("Add") })
            )
        }
    }
}

struct CreateWashroomView_Previews: PreviewProvider {
    static var previews: some View {
        CreateWashroomView(show: .constant(true))
    }
}

struct AmenitiesSelectionView: View {
    @Binding var amenities: [Washroom.Amenity]

    var body: some View {
        ForEach(Washroom.Amenity.allCases, id: \.self) { amenity in
            HStack {
                Text("\(amenity.rawValue)")
                Spacer()
                Text("\(amenity.emoji ?? "")")
                if self.amenities.contains(amenity) {
                    Image(systemName: "checkmark.circle.fill")
                } else {
                    Image(systemName: "circle")
                }
            }.onTapGesture {
                if self.amenities.contains(amenity) {
                    self.amenities.removeAll(where: { $0 == amenity})
                } else {
                    self.amenities.append(amenity)
                }
            }
        }

    }
}


struct GenderSelectionView: View {
    @Binding var gender: Washroom.Gender

    var body: some View {
        Picker(selection: $gender, label: Text("Gender")) {
            ForEach(Washroom.Gender.allCases, id: \.self) { gender in
                Text(gender.description).tag(gender)
            }
        }
        .pickerStyle(SegmentedPickerStyle())
    }
}
