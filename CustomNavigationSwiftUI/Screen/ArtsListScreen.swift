//
//  ArtsListScreen.swift
//  CustomNavigationSwiftUI
//
//  Created by Даниил Дорожкин on 18/09/2021.
//

import SwiftUI
import Networking

struct ArtsListScreen: View {
    
    @EnvironmentObject var sourceModel : CategoriesModel
    
    var body: some View {
        VStack {
            PopButton(dest: .previous, Label: {
                Text("Back")
            }, action: {
                sourceModel.artObjectsList.removeAll()
            })
            List {
                ForEach(sourceModel.artObjectsList) { item in
                    ArtObjectCell(item: item)
                        .environmentObject(sourceModel)
                }
            }
            .onAppear {
                print("Appearing fucking screen")
            }
        }
    }
}

struct ArtObjectCell: View {
    @EnvironmentObject var dataSourceModel: DataSourceModel
    
    var item: ArtObject
    
    var body: some View {
        VStack {
            Text(item.title)
                .padding(.leading)
            Text(item.principalOrFirstMaker)
                .padding(.leading)
        }
    }
}
