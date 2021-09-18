//
//  AuthorsScreen.swift
//  CustomNavigationSwiftUI
//
//  Created by Даниил Дорожкин on 18/09/2021.
//

import SwiftUI

struct AuthorsScreen: View {
    
    @EnvironmentObject var sourceModel : DataSourceModel
    
    var body: some View {
        List(sourceModel.authorsList) { place in
            Text(place.key)
        }
    }
}
