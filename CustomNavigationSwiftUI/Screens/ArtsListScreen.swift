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
                List {
                    ForEach(sourceModel.artObjectsList) { item in
                        ArtObjectCell(item: item)
                    }
                }
                .onAppear {
                    print("Appearing fucking screen")
                }
            }
            
            Spacer()
            Spacer()
            Divider()
            
            PopButton(dest: .previous, Label: {
                Text("Close")
            }, action: {
                sourceModel.artObjectsList.removeAll()
            })
        }
    }
}


