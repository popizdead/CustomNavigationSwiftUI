//
//  PlacesModel.swift
//  CustomNavigationSwiftUI
//
//  Created by Даниил Дорожкин on 18/09/2021.
//

import Networking
import SwiftUI

//MARK:-SOURCE
class CategoriesModel: ObservableObject {
    
    enum CategoryType {
        case places
        case authors
    }
    
    //Category source
    @Published var categoriesList: [Facet] = .init()
    
    init(type: CategoryType) {
        getAllCategoriesOf(type)
    }
    
    //MARK:-REQUEST
    private func getAllCategoriesOf(_ type: CategoryType) {
        MuseumAPI.getRequest(key: "s4QQN2YY", p: 0) { response, error in
            if let err = error {
                print(err)
            } else {
                guard let source = response else { return }
                
                switch type {
                case .authors:
                    self.appendCategories(source, type: "principalMaker")
                case .places:
                    self.appendCategories(source, type: "place")
                }
            }
        }
    }
    
    private func appendCategories(_ source: ResponseSource, type: String) {
        guard let categoriesSource = source.facets?.first(where: {
            $0.name == type
        })?.facets?.cleanFromOptionalFacet() else { return }
    
        self.categoriesList = categoriesSource
    }
}
