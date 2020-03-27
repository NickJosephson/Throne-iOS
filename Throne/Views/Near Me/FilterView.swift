//
//  FilterView.swift
//  Throne
//
//  Created by Nicholas Josephson on 2020-03-08.
//  Copyright © 2020 Throne. All rights reserved.
//

import SwiftUI

struct FilterView: View {
    @Binding var show: Bool
    @ObservedObject private var nearMe = NearMe.shared
    @ObservedObject private var settings = PersistentSettings.shared
    @State private var newFilter = Filter()
    
    var body: some View {
        NavigationView {
            Form {
                // Amenities Selection
                Section(
                    footer: Text("Only applies to all \(settings.preferredTerm)s list.").foregroundColor(.secondary)
                ) {
                    NavigationLink(
                        destination: Form {
                            AmenitiesSelectionView(amenities: self.$newFilter.amenities)
                        }.navigationBarTitle("Amenities"),
                        label: {
                            HStack {
                                Text("Amenities")
                                    .fixedSize()
                                Spacer()
                                Text("\(self.newFilter.amenities.count) Selected")
                                    .foregroundColor(.secondary)
                            }
                        }
                    )
                }
                
                // Radius Selection
                Section {
                    VStack {
                        HStack {
                            Text("Radius")
                            Spacer()
                            Text(self.newFilter.radiusDescription)
                                .foregroundColor(.secondary)
                                .accessibility(hidden: true)
                        }
                        Slider(
                            value: self.$newFilter.radius,
                            in: 0.1...50.0
                        )
                        .accessibility(value: Text(self.newFilter.radiusDescription))
                    }
                    .accessibilityElement(children: .combine)
                }
                
                // Show Empty Buildings Toggle
                Section {
                    Toggle(
                        isOn: self.$newFilter.showEmptyBuildings,
                        label: { Text("Show Empty Buildings") }
                    )
                }
                
                // Restore Defaults Button
                Section {
                    Button(
                        action: { self.newFilter = Filter() },
                        label: { Text("Restore Defaults") }
                    )
                }
            }
            .navigationBarTitle("Filter", displayMode: .inline)
            .navigationBarItems(
                leading: Button(action: { self.show = false }, label: { Text("Cancel") }),
                trailing: Button(
                    action: {
                        self.nearMe.filter = self.newFilter
                        self.show = false
                    },
                    label: { Text("Apply") }
                )
            )
        }
        .frame(idealWidth: 350, idealHeight: 500)
        .onAppear {
            self.newFilter = self.nearMe.filter
        }
    }
}

struct FilterView_Previews: PreviewProvider {
    static var previews: some View {
        FilterView(show: .constant(true))
    }
}
