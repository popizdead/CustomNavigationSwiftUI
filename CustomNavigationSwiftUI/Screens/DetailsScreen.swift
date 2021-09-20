//
//  DetailsScreen.swift
//  CustomNavigationSwiftUI
//
//  Created by Даниил Дорожкин on 18/09/2021.
//

import SwiftUI
import Networking

struct DetailsScreen : View {
    
    var reviewArt : ArtObject?
    
    var body: some View {
        VStack {
            PopButton(dest: .previous, Label: {
                Text("Back")
            }, action: {})
            Text(reviewArt?.title ?? "no data")
        }
    }
}
