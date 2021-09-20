//
//  DetailModel.swift
//  CustomNavigationSwiftUI
//
//  Created by Даниил Дорожкин on 18/09/2021.
//

import SwiftUI
import Networking

class DetailModel: ObservableObject {
    @Published var reviewArt : ArtObject?
    
    func requestForObject(_ id: String) {
        MuseumAPI.getRequest(objectNumber: id, key: "s4QQN2YY") { data, error in
            if let err = error {
                print(err)
            }
            
            guard let object = data?.artObject else { return }
            self.reviewArt = object
        }
    }
}
