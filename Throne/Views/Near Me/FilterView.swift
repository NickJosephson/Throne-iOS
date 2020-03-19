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
    @ObservedObject var nearMe: NearMe
    @State private var newFilter = Filter()
    
    var body: some View {
        NavigationView {
            Form {
                NavigationLink(
                    destination: Form(content: { AmenitiesSelectionView(amenities: self.$newFilter.amenities) }),
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
                
                Section() {
                    Toggle(isOn: self.$newFilter.showEmptyBuildings, label: { Text("Show Empty Buildings") })
                }
                
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
                trailing: Button(action: {
                    self.nearMe.filter = self.newFilter
                    self.show = false
                }, label: { Text("Apply") })
            )
        }
        .onAppear {
            self.newFilter = self.nearMe.filter
        }
    }
}


struct FilterView_Previews: PreviewProvider {
    static var previews: some View {
        FilterView(show: .constant(true), nearMe: NearMe.shared)
    }
}
