//
//  PlacesViewModel.swift
//  CustomNavigationSwiftUI
//
//  Created by Даниил Дорожкин on 18/09/2021.
//

import SwiftUI
import Networking

//MARK: -SOURCE
class DataSourceModel: ObservableObject {
    
    @Published var placesList: [Facet] = .init()
    @Published var authorsList: [Facet] = .init()
    @Published var topItems: [ArtObject] = .init()
    
    @Published var currentPage: Int = 0
    @Published var isPageLoading: Bool = false
    
    init() {
        getRequst()
    }
    
    func requestNextTopPage() {
        guard isPageLoading == false else { return }
        
        currentPage += 1
        isPageLoading = true
        
        FacetsAPI.getFacetsList(key: "s4QQN2YY", p: currentPage) { response, error in
            if let err = error {
                print(err)
            } else {
                guard let source = response else { return }
                
                self.appendTopItemsToSource(reponse: source)
            }
        }
    }
    
    private func appendTopItemsToSource(reponse: ResponseSource) {
        guard let topSource = reponse.artObjects else { return }
        
        self.topItems.append(contentsOf: topSource)
        isPageLoading = false
    }
    
    //MARK: -REQUESTS
    private func getRequst() {
        FacetsAPI.getFacetsList(key: "s4QQN2YY", p: currentPage) { response, error in
            if let err = error {
                print(err)
            } else {
                guard let source = response else { return }
                let requestEnums : [itemsType] = [.authors, .places, .top]
                requestEnums.forEach({
                    self.fetchItemsFromSource(source, type: $0)
                })
                
                self.currentPage += 1
            }
        }
    }
}

extension DataSourceModel {
    enum itemsType {
        case top
        case authors
        case places
    }
    
    func fetchItemsFromSource(_ source: ResponseSource, type: itemsType) {
        switch type {
        case .authors:
            guard let authorsSource = source.facets?.first(where: {
                $0.name == "principalMaker"
            })?.facets?.cleanFromOptionalFacet() else { return }
            
            self.authorsList = authorsSource
        case .places:
            guard let placesSource = source.facets?.first(where: {
                $0.name == "place"
            })?.facets?.cleanFromOptionalFacet() else { return }
        
            self.placesList = placesSource
        case .top:
            guard let topSource = source.artObjects else { return }
            
            self.topItems = topSource
        }
    }
}