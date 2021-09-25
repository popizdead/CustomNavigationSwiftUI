//
//  ArtsListScreen.swift
//  CustomNavigationSwiftUI
//
//  Created by Даниил Дорожкин on 18/09/2021.
//

import SwiftUI
import SDWebImageSwiftUI
import Networking

struct ArtsListScreen: View {
    
    @EnvironmentObject var sourceModel : CategoriesModel
    
    var body: some View {
        VStack {
            VStack {
                HStack {
                    Spacer()
                    Text(sourceModel.currentSearch)
                        .font(.headline)
                    Spacer()
                }
                List {
                    ForEach(sourceModel.artObjectsList) { item in
                        ArtObjectCell(item: item)
                    }
                }
            }
            
            Spacer()
            Spacer()
            Divider()
            
            PopButton(dest: .previous, Label: {
                Text("Close")
                    .font(.headline)
            }, action: {
                sourceModel.artObjectsList.removeAll()
            })
        }
    }
}


