//
//  AuthorsViewModel.swift
//  CustomNavigationSwiftUI
//
//  Created by Даниил Дорожкин on 18/09/2021.
//
import SwiftUI
import Networking

//MARK:-SOURCE
class PlacesViewModel: ObservableObject {
    
    //Category source
    @Published var placesList: [Facet] = .init()
    
    init() {
        getAllPlaces()
    }
    
    //MARK:-REQUEST
    private func getAllPlaces() {
        MuseumAPI.getRequest(key: "s4QQN2YY", p: 0) { response, error in
            if let err = error {
                print(err)
            } else {
                guard let source = response else { return }
                
                self.appendPlaces(source)
            }
        }
    }
    
    private func appendPlaces(_ source: ResponseSource) {
        guard let placesSource = source.facets?.first(where: {
            $0.name == "place"
        })?.facets?.cleanFromOptionalFacet() else { return }
    
        self.placesList = placesSource
    }
}
