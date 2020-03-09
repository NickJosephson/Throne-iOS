//
//  WashroomDetailView.swift
//  Throne
//
//  Created by Nicholas Josephson on 2020-01-30.
//  Copyright © 2020 Throne. All rights reserved.
//

import SwiftUI

struct WashroomDetailView: View {
    @ObservedObject var washroom: Washroom
    @State private var showShareSheet = false
    
    var body: some View {
        List {
            Section(header: Text(washroom.buildingTitle).font(.title)) {
                Text("\(washroom.gender.emoji) Floor \(washroom.floor) \(washroom.additionalTitle)").font(.title)
                    .accessibility(label: Text("\(washroom.gender.description) Floor \(washroom.floor) \(washroom.additionalTitle)"))
            }
            Section(header: Text("Details")) {
                HStack {
                    Text("Stalls")
                    Spacer()
                    Text("\(washroom.stallsCount)")
                }
                    .accessibilityElement(children: .combine)
                if washroom.urinalsCount > 0 {
                    HStack {
                        Text("Urinals")
                        Spacer()
                        Text("\(washroom.urinalsCount)")
                    }
                        .accessibilityElement(children: .combine)
                }
                NavigationLink(destination: AmenitiesView(amenities: self.washroom.amenities)) {
                    Text("Amenities")
                        .fixedSize()
                        .layoutPriority(1)
                    Spacer()
                    CompactAmenitiesView(amenities: self.washroom.amenities)
                        .layoutPriority(1)
                }
                .disabled(washroom.amenities.count == 0)
                .opacity(washroom.amenities.count == 0 ? 0.5 : 1.0)
            }
            Section(header: Text("Ratings")) {
                HStack {
                    Text("✨").accessibility(hidden: true)
                    RatingView(rating: washroom.averageRatings.cleanliness, label: "Cleanliness")
                }
                HStack {
                    Text("🤚").accessibility(hidden: true)
                    RatingView(rating: washroom.averageRatings.privacy, label: "Privacy")
                }
                HStack {
                    Text("🧻").accessibility(hidden: true)
                    RatingView(rating: washroom.averageRatings.toiletPaperQuality, label: "Paper Quality")
                }
                HStack {
                    Text("👃").accessibility(hidden: true)
                    RatingView(rating: washroom.averageRatings.smell, label: "Smell")
                }
                NavigationLink(destination: ReviewsView(washroom: washroom)) {
                    Text("Reviews")
                    Spacer()
                    if washroom.reviewsCount != nil {
                        Text("\(washroom.reviewsCount!)")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    }
                }
            }
            Section(header: Text("Location")) {
                NavigationLink(destination: MapDetailView(startLocation: washroom.location)) {
                    MapPreviewView(startLocation: washroom.location)
                        .frame(minWidth: nil, idealWidth: nil, maxWidth: nil, minHeight: 200, idealHeight: 200, maxHeight: 200, alignment: .center)
                        .cornerRadius(10)
                }.accessibility(label: Text("Location on map"))
            }
            
            Section {
                Button(action: {
                    guard let url = URL(string: "https://umanitoba.ca/campus/physical_plant/adminss/request/request.php") else { return }
                    UIApplication.shared.open(url)
                }, label: {
                    HStack {
                        Image(systemName: "exclamationmark.bubble")
                        Text("Report Maintenance Issue")
                    }
                })
            }
        }
        .listStyle(GroupedListStyle())
        .navigationBarTitle("", displayMode: .inline)
        .navigationBarItems(trailing:
            HStack(spacing: 20) {
                FavoriteButton(washroom: self.washroom)
                ReviewButton(washroom: self.washroom)
                Button(
                    action: {
                        self.showShareSheet = true
                    },
                    label: {
                        Image(systemName: "square.and.arrow.up")
                            .accessibility(label: Text("Share Washroom"))
                    }
                )
                    .popover(isPresented: $showShareSheet) {
                        ShareView(activityItems: [self.washroom.webURL], callback: {
                            self.showShareSheet = false
                        })
                    }
            }
        )
    }
}

struct WashroomDetailView_Previews: PreviewProvider {
    static var previews: some View {
        return WashroomDetailView(washroom: Washroom())
    }
}

extension WashroomDetailView {
    init(id: Int) {
        self.washroom = Washroom()
        self.washroom.updateDetailsFrom(id: id)
    }
}
