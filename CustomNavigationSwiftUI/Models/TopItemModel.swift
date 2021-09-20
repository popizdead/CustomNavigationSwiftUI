//
//  TopItemModel.swift
//  CustomNavigationSwiftUI
//
//  Created by Даниил Дорожкин on 18/09/2021.
//

import SwiftUI
import Networking

//MARK: -SOURCE
class TopItemModel: ObservableObject {
    
    @Published var topItemsList: [ArtObject] = .init()
    
    @Published var currentPage: Int = 0
    @Published var isPageLoading: Bool = false
    
    
    init() {
        getRequst()
    }
    
    //MARK:-PAGING
    //Next page
    func requestNextTopPage() {
        guard isPageLoading == false else { return }
        
        currentPage += 1
        isPageLoading = true
        
        MuseumAPI.getRequest(objectNumber: "", key: "s4QQN2YY", p: currentPage) { response, error in
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
         
        self.topItemsList.append(contentsOf: topSource)
        isPageLoading = false
    }
    
    //MARK: -REQUESTS
    private func getRequst() {
        isPageLoading = true
        MuseumAPI.getRequest(objectNumber: "", key: "s4QQN2YY", p: currentPage) { response, error in
            if let err = error {
                print(err)
            } else {
                guard let source = response else { return }
                
                self.fetchItemsFromSource(source)
                self.currentPage += 1
                self.isPageLoading = false
            }
        }
    }
    
    private func fetchItemsFromSource(_ source: ResponseSource) {
        guard let topSource = source.artObjects else { return }
        
        print("there's \(topSource.count) items!!!")
        self.topItemsList = topSource
    }
}
