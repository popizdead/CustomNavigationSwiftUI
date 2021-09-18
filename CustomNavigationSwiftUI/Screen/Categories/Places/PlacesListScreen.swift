//
//  PlacesListScreen.swift
//  CustomNavigationSwiftUI
//
//  Created by Даниил Дорожкин on 18/09/2021.
//

import SwiftUI
import Networking


struct PlacesListScreen: View {
    
    var body: some View {
        NavControllerView(transition: .custom(.present)) {
            FirstPlaces()
        }
    }
}

struct FirstPlaces: View {
    
    @ObservedObject var sourceModel : CategoriesModel = .init(type: .places)
   
    var body: some View {
            VStack {
                descriptionText
                categoryList
            }
    }
    
    var categoryList: some View {
        List {
            ForEach(sourceModel.categoriesList) { place in
                PlaceCell(place: place)
                    .environmentObject(sourceModel)
            }
        }
    }
    
    var descriptionText: some View {
        Text("\(sourceModel.categoriesList.count) items")
            .padding(.leading)
    }
}

struct PlaceCell: View {
    @EnvironmentObject var dataSourceModel: CategoriesModel
    
    var place: Facet
    
    var body: some View {
        PushButton(dest: ArtsListScreen().environmentObject(dataSourceModel), Label: {
            Text(place.key)
        }, action: {
            dataSourceModel.getSearchRequest(place.key)
        })
    }
}
