//
//  AuthorsScreen.swift
//  CustomNavigationSwiftUI
//
//  Created by Даниил Дорожкин on 18/09/2021.
//

import SwiftUI
import Networking

struct AuthorsScreen: View {
    
    var body: some View {
        NavControllerView(transition: .custom(.present)) {
            FirstAuthorsScreen()
        }
    }
}

struct FirstAuthorsScreen: View {
    
    @ObservedObject var sourceModel : CategoriesModel = .init(type: .authors)
    
    var body: some View {
        List {
            ForEach(sourceModel.categoriesList) { author in
                AuthorCell(author: author)
                    .environmentObject(sourceModel)
            }
        }
    }
}

struct AuthorCell: View {
    @EnvironmentObject var dataSourceModel: CategoriesModel
    
    var author: Facet
    var decoded = "url components"
    
    
    var body: some View {
        PushButton(dest: ArtsListScreen().environmentObject(dataSourceModel), Label: {
            Text(author.key)
        }, action: {
            guard let searchRequest = author.key.addingPercentEncoding(
                withAllowedCharacters: .urlQueryAllowed
            ) else { return }
            
            dataSourceModel.getSearchRequest(searchRequest)
        })
    }
}
