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
    @State private var amenities: [Amenity] = []
    
    var body: some View {
        NavigationView {
            Form {
                NavigationLink(
                    destination: Form(content: { AmenitiesSelectionView(amenities: self.$amenities) }),
                    label: {
                        HStack {
                            Text("Amenities")
                                .fixedSize()
                            Spacer()
                            Text("\(self.amenities.count) Selected")
                                .foregroundColor(.secondary)
                        }
                    }
                )
                
                Section {
                    Button(action: {
                        self.amenities = []
                    }, label: { Text("Restore Defaults") })
                }
            }
            .navigationBarTitle("Filter", displayMode: .inline)
            .navigationBarItems(
                leading: Button(action: { self.show = false }, label: { Text("Cancel") }),
                trailing: Button(action: {
                    self.nearMe.filterAmenities = self.amenities
                    self.show = false
                }, label: { Text("Apply") })
            )
        }
            .onAppear {
                self.amenities = self.nearMe.filterAmenities
            }
    }
}


struct FilterView_Previews: PreviewProvider {
    static var previews: some View {
        FilterView(show: .constant(true), nearMe: NearMe.shared)
    }
}
