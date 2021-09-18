//
//  PlacesViewModel.swift
//  CustomNavigationSwiftUI
//
//  Created by Даниил Дорожкин on 18/09/2021.
//

import SwiftUI
import Networking

final class ListScreenViewModel: ObservableObject {
    
    @Published var placesList: [Facet] = .init()
    
    init() {
        FacetsAPI.getFacetsList(key: "s4QQN2YY") { source, error in
            if let facetsSource = source?.facets {
                if let placesSource = facetsSource.first(where: {
                    $0.name == "place"
                }) {
                    placesSource.facets?.forEach({
                        print($0.key)
                    })
                }
            }
        }
    }
}

