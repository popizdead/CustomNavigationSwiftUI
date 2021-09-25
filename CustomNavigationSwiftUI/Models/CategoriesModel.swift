//
//  CategoriesModel.swift
//  CustomNavigationSwiftUI
//
//  Created by Даниил Дорожкин on 20/09/2021.
//

import Networking
import SwiftUI

//MARK:-SOURCE
class CategoriesModel: ObservableObject {
    
    //Category source
    @Published var categoriesList: [Facet] = .init()
    @Published var artObjectsList: [ArtObject] = .init()
    
    @Published var currentPage: Int = 1
    @Published var isPageLoading: Bool = false
    
    @Published var currentSearch = String()
    
    init(type: CategoryType) {
        getAllCategoriesOf(type)
    }
    
    //MARK:-REQUEST
    private func getAllCategoriesOf(_ type: CategoryType) {
        MuseumAPI.getRequest(objectNumber: "", key: "s4QQN2YY", p: 0) { response, error in
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
    
    //MARK:-SEARCH
    func getSearchRequest() {
        guard let searchRequest = self.currentSearch.addingPercentEncoding(
            withAllowedCharacters: .urlQueryAllowed
        ) else { return }
        self.isPageLoading = true
        
        MuseumAPI.getRequest(objectNumber: "", key: "s4QQN2YY", q: searchRequest, p: currentPage, apiResponseQueue: .main) { response, error in
            if let err = error {
                print(err)
            } else {
                guard let source = response else { return }
                
                self.currentPage += 1
                self.appendSearchItemsToSource(response: source)
            }
        }
    }
    
    private func appendSearchItemsToSource(response: ResponseSource) {
        guard let artObject = response.artObjects else { return }
        
        self.artObjectsList = artObject
        self.isPageLoading = false
    }
    
    //MARK:-PAGING
    func requestNextPage() {
        guard isPageLoading == false else { return }
        isPageLoading = true
        self.currentPage += 1
        
        MuseumAPI.getRequest(objectNumber: "", key: "s4QQN2YY", q: currentSearch,  p: currentPage) { response, error in
            if let err = error {
                print(err)
            } else {
                guard let source = response else { return }
                
                self.appendItemsToSource(reponse: source)
            }
        }
    }
    
    private func appendItemsToSource(reponse: ResponseSource) {
        guard let topSource = reponse.artObjects else { return }
        
        artObjectsList.append(contentsOf: topSource)
        artObjectsList = artObjectsList.uniqued()
        
        isPageLoading = false
    }
    
}
