//
//  Networking+.swift
//  CustomNavigationSwiftUI
//
//  Created by Даниил Дорожкин on 18/09/2021.
//

import Networking

extension Facet: Identifiable {
    
    public var id: String { self.key }
    
}

extension ArtObject: Identifiable {
    
    public var id: String { self.title }
    
}

enum CategoryType {
    case places
    case authors
}
